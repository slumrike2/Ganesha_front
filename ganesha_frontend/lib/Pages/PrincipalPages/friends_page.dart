import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/user_avatar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Friend {
  final String name;
  final String userid;
  final int score;

  Friend({required this.name, required this.score, required this.userid});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      userid: json['idUsuario'],
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
  List<Friend> searchResults = [];
  late Future<void> _friendsFuture;
  TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _friendsFuture = fetchFriends();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<bool> addFriendPost(friendId) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/friends/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['API_KEY']}',
        },
        body: jsonEncode({
          'id_usuario': Supabase.instance.client.auth.currentSession!.user.id,
          'id_amigo': friendId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Failed to add friend: $e');
      throw false;
    }
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

  Future<void> searchFriends(String query) async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/user/like_username/$query'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['API_KEY']}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> searchResultsJson = jsonDecode(response.body);
        List<Friend> fetchedFriends =
            searchResultsJson.map((json) => Friend.fromJson(json)).toList();
        // Remove friends that are already in the friends list
        fetchedFriends.removeWhere((friend) => friends
            .any((existingFriend) => existingFriend.userid == friend.userid));
        setState(() {
          searchResults = fetchedFriends;
        });
      } else {
        print('Failed to search friends');
      }
    } catch (e) {
      print('Failed to search friends: $e');
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true;
      });
      searchFriends(query);
    } else {
      setState(() {
        isSearching = false;
        searchResults = [];
      });
    }
  }

  Future<void> addFriend(Friend friend) async {
    // Mockup of the fetch, replace with actual API call
    bool added = await addFriendPost(friend.userid);

    if (!added) {
      return;
    }

    setState(() {
      friends.add(friend);
      isSearching = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar amigos...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tus amigos',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<void>(
                future: _friendsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error al cargar amigos'));
                  } else {
                    final displayList = isSearching ? searchResults : friends;
                    return ListView.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        final friend = displayList[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 8), // Adjusted margin
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8), // Adjusted padding
                            leading: UserAvatar(
                                name: friend.name), // Added UserAvatar
                            title: Text(
                              friend.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors
                                      .black), // Adjusted font size and color
                            ),
                            trailing: isSearching
                                ? IconButton(
                                    icon: Icon(Icons.add, color: Colors.green),
                                    onPressed: () => addFriend(friend),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.monetization_on,
                                          color: Colors.yellow),
                                      SizedBox(width: 4),
                                      Text(
                                        '${friend.score}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors
                                                .black), // Adjusted font size and color
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
