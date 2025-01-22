import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ganesha_frontend/Components/music_preview.dart';
import 'package:ganesha_frontend/dartTypes.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Musica', style: TextStyle(fontSize: 32, color: Colors.white)),
          FutureBuilder<List<Song>>(
              future: getSongs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.all(32),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                                spacing: 16,
                                children: snapshot.data!
                                    .map((song) => MusicPreview(
                                          title: song.titulo,
                                          unloock: song.unloock,
                                          price: song.costePun,
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
        if (jsonDecode(responseUserSongs.body).any((song) =>
            song['id_cancion'] == songs.last.idCancion &&
            song['id_usuario'] == supabase.auth.currentSession?.user.id)) {
          songs.last.unloock = true;
        }
      }
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
