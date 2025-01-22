import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_controller.dart';

class MusicPreview extends StatelessWidget {
  const MusicPreview(
      {super.key, required this.title, this.unloock = true, this.price = 0});
  final String title;
  final bool unloock;
  final int price;

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: title, style: TextStyle(color: Colors.white)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 100);

    final isOverflowing = textPainter.didExceedMaxLines;
    final AudioPlayer _audioPlayer = AudioPlayer(); 

    return Container(
        decoration: BoxDecoration(
          color: unloock
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
                        text: title,
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
                      title,
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
            ),
            if (!unloock)
              Row(
                children: [
                  Text(
                    '$price',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.monetization_on, color: Colors.yellow),
                ],
              ),
            (!unloock)
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.lock_open, color: Colors.white))
                : IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.card_giftcard_outlined,
                        color: Colors.white)),
            if (unloock)
              IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.white),
                onPressed: () async {
                    var path = 'audio/${title}.mp3';
                    await AudioController().play(AssetSource(path));
                },
              ),
          ],
        ));
  }
}
