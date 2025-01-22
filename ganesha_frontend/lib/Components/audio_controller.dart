import 'package:audioplayers/audioplayers.dart';

class AudioController {
  static final AudioController _instance = AudioController._internal();

  factory AudioController() {
    return _instance;
  }

  AudioController._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play(AssetSource filePath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(filePath);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }
}
