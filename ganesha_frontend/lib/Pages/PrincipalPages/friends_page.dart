import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/user_avatar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Friend {
  final String name;
  final int score;

  Friend({required this.name, required this.score});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      name: json['username'],
      score: json['puntaje'],
    );
  }
}

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<Friend> friends = [];

  @override
  void initState() {
    super.initState();
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    try {
      final responseUserFriends = await http.get(
        Uri.parse(
            '${dotenv.env['API_URL']}/friends/user/${Supabase.instance.client.auth.currentSession!.user.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['API_KEY']}',
        },
      );

      if (responseUserFriends.statusCode == 200) {
        List<Friend> fetchedFriends = [];
        List<dynamic> userFriends = jsonDecode(responseUserFriends.body);

        for (var friend in userFriends) {
          fetchedFriends.add(Friend.fromJson(friend));
        }
        setState(() {
          friends = fetchedFriends;
        });
      } else {
        print('Failed to load friends');
      }
    } catch (e) {
      print('Failed to load friends: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondo.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withAlpha(100),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16), // Adjusted padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Amigos', 
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Tus amigos',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8), // Adjusted margin
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjusted padding
                          leading: UserAvatar(name: friend.name), // Added UserAvatar
                          title: Text(
                            friend.name,
                            style: TextStyle(fontSize: 20, color: Colors.black), // Adjusted font size and color
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.monetization_on, color: Colors.yellow),
                              SizedBox(width: 4),
                              Text(
                                '${friend.score}',
                                style: TextStyle(fontSize: 20, color: Colors.black), // Adjusted font size and color
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}