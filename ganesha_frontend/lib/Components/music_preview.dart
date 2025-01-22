import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_controller.dart';

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
  bool isPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await AudioController().stop();
    } else {
      var path = 'audio/${widget.title}.mp3';
      await AudioController().play(AssetSource(path));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.title, style: TextStyle(color: Colors.white)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 100);

    final isOverflowing = textPainter.didExceedMaxLines;

    return Container(
        decoration: BoxDecoration(
          color: widget.unloock
              ? const Color.fromARGB(255, 137, 187, 211)
              : const Color.fromARGB(255, 58, 75, 124),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
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
                        startPadding:
                            0.0, // Ensure text starts from the beginning
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
                    onPressed: () {},
                    icon: Icon(Icons.card_giftcard_outlined,
                        color: Colors.white)),
            if (widget.unloock)
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white),
                onPressed: _togglePlayPause,
              ),
          ],
        ));
  }
}
