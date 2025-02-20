import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ganesha_frontend/Components/music_preview.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class MusicPage extends StatelessWidget {
  final Future<void> Function() refetchUserData;

  const MusicPage({super.key, required this.refetchUserData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Música', style: TextStyle(fontSize: 32, color: Colors.white)),
          Text(
            'Aqui puedes canjear tus puntos para desbloquear y regalarle canciones a tus amigos, asi como escuchar tu propia música',
            style: TextStyle(fontSize: 12, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          FutureBuilder<List<Song>>(
              future: getSongs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final songs = snapshot.data!;
                  songs.sort((a, b) {
                    if (a.unloock && !b.unloock) return -1;
                    if (!a.unloock && b.unloock) return 1;
                    return a.costePun.compareTo(b.costePun);
                  });
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.all(32),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                                spacing: 16,
                                children: songs
                                    .map((song) => MusicPreview(
                                          title: song.titulo,
                                          unloock: song.unloock,
                                          price: song.costePun,
                                          songId: song.idCancion,
                                          refetchUserData: refetchUserData,
                                        ))
                                    .toList()),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Future<List<Song>> getSongs() async {
    final responseSongs =
        await http.get(Uri.parse('${dotenv.env['API_URL']}/songs'), headers: {
      'Content-Type': 'application/json',
      'Authorization': '${dotenv.env['API_KEY']}',
    });

    SupabaseClient supabase = Supabase.instance.client;

    final responseUserSongs = await http.get(
        Uri.parse(
            '${dotenv.env['API_URL']}/user/songs/${supabase.auth.currentSession!.user.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['API_KEY']}',
        });

    if (responseSongs.statusCode == 200 &&
        responseUserSongs.statusCode == 200) {
      List<Song> songs = [];
      for (var song in jsonDecode(responseSongs.body)) {
        songs.add(Song.fromJson(song));
        if (jsonDecode(responseUserSongs.body).any((userSong) =>
            userSong['id_cancion'] == songs.last.idCancion &&
            userSong['id_usuario'] == supabase.auth.currentSession?.user.id)) {
          songs.last.unloock = true;
        }
      }
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

}
