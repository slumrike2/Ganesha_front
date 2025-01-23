import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'user_avatar.dart';
import 'audio_controller.dart';
import 'package:ganesha_frontend/Pages/PrincipalPages/gift_confirmation_page.dart';

class MusicPreview extends StatefulWidget {
  final String title;
  final bool unloock;
  final int price;

  const MusicPreview({
    Key? key,
    required this.title,
    required this.unloock,
    required this.price,
  }) : super(key: key);

  @override
  _MusicPreviewState createState() => _MusicPreviewState();
}

class _MusicPreviewState extends State<MusicPreview> {
  static _MusicPreviewState? activeInstance;
  bool isPlaying = false;
  bool showFriends = false;
  List<String> friends = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> fetchFriends() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${dotenv.env['API_URL']}/friends/user/${Supabase.instance.client.auth.currentSession!.user.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['API_KEY']}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> friendsJson = jsonDecode(response.body);
        List<String> fetchedFriends = friendsJson.map((friend) => friend['username'] as String).toList();
        if (mounted) {
          setState(() {
            friends = fetchedFriends;
          });
        }
      } else {
        print('Failed to load friends');
      }
    } catch (e) {
      print('Failed to load friends: $e');
    }
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await AudioController().stop();
    } else {
      var path = 'audio/${widget.title}.mp3';
      await AudioController().play(AssetSource(path));
    }
    if (mounted) {
      setState(() {
        isPlaying = !isPlaying;
      });
    }
  }

  void _toggleShowFriends() {
    if (activeInstance != null && activeInstance != this) {
      if (activeInstance!.mounted) {
        activeInstance!.setState(() {
          activeInstance!.showFriends = false;
        });
      }
    }

    if (friends.isEmpty) {
      fetchFriends().then((_) {
        if (mounted) {
          setState(() {
            showFriends = !showFriends;
            activeInstance = showFriends ? this : null;
          });
        }
      });
    } else {
      if (mounted) {
        setState(() {
          showFriends = !showFriends;
          activeInstance = showFriends ? this : null;
        });
      }
    }
  }

  void _navigateToGiftConfirmation(BuildContext context, String friendName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GiftConfirmationPage(
          friendName: friendName,
          songTitle: widget.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final friendsToShow = friends.take(3).toList();
    final remainingFriends = friends.length - friendsToShow.length;
    final textPainter = TextPainter(
      text: TextSpan(text: widget.title, style: TextStyle(color: Colors.white)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 100);

    final isOverflowing = textPainter.didExceedMaxLines;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(top: showFriends ? 50.0 : 16.0), // Adjust margin dynamically
              decoration: BoxDecoration(
                color: widget.unloock
                    ? const Color.fromARGB(255, 137, 187, 211)
                    : const Color.fromARGB(255, 58, 75, 124),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.music_note, color: Colors.white),
                      ),
                      Expanded(
                        child: isOverflowing
                            ? SizedBox(
                                width: double.infinity,
                                height: 15.0,
                                // Set a fixed height for the Marquee
                                child: Marquee(
                                  text: widget.title,
                                  style: TextStyle(color: Colors.white),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 80.0,
                                  pauseAfterRound: Duration(seconds: 25),
                                  velocity: 30.0,
                                  startPadding: 0.0, // Ensure text starts from the beginning
                                ),
                              )
                            : Text(
                                widget.title,
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                      ),
                      if (!widget.unloock)
                        Row(
                          children: [
                            Text(
                              '${widget.price}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.monetization_on, color: Colors.yellow),
                          ],
                        ),
                      (!widget.unloock)
                          ? IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.lock_open, color: Colors.white))
                          : IconButton(
                              onPressed: _toggleShowFriends,
                              icon: Icon(Icons.card_giftcard_outlined, color: Colors.white)),
                      if (widget.unloock)
                        IconButton(
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                          onPressed: _togglePlayPause,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (showFriends)
              Positioned(
                top: 0, // Reverted position to the original value
                right: 0,
                child: Row(
                  children: [
                    ...friendsToShow.map((friend) => GestureDetector(
                      onTap: () => _navigateToGiftConfirmation(context, friend),
                      child: UserAvatar(name: friend),
                    )).toList(),
                    if (remainingFriends > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(
                            '+$remainingFriends',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}