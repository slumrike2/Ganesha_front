import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/music_preview.dart';

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
          Expanded(
              child: Container(
            padding: EdgeInsets.all(32),
            child: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    spacing: 16,
                    children: [
                      for (int i = 1; i <= 10; i++)
                        MusicPreview(
                            title:
                                'Cancion extremadamente larga que no se distinque $i'),
                      for (int i = 1; i <= 10; i++)
                        MusicPreview(
                            title: 'Cancion $i', unloock: false, price: 100),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
