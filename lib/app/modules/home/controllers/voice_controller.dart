import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  var isPlaying = false.obs;
  var currentVoice = 'default'.obs;

  // Mengatur suara yang ingin diputar
  Future<void> speak(String text) async {
    if (isPlaying.value) {
      await flutterTts.stop();
    }

    switch (currentVoice.value) {
      case 'default':
        await flutterTts.setLanguage('id-ID');
        await flutterTts.setPitch(1.0);
        break;
      case 'robot':
        await flutterTts.setLanguage('id-ID');
        await flutterTts.setPitch(0.8);
        break;
      case 'female':
        await flutterTts.setLanguage('id-ID');
        await flutterTts.setPitch(1.5);
        break;
      default:
        await flutterTts.setLanguage('id-ID');
        await flutterTts.setPitch(1.0);
    }

    await flutterTts.speak(text);
    isPlaying.value = true;
  }

  Future<void> stop() async {
    await flutterTts.stop();
    isPlaying.value = false;
  }

  void changeVoice(String voice) {
    currentVoice.value = voice;
  }
}
