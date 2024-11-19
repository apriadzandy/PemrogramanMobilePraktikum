import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';

class SpeechController extends GetxController {
  // Speech-to-text related variables
  stt.SpeechToText speech = stt.SpeechToText();
  RxString recognizedText = ''.obs;
  RxBool isListening = false.obs;
  RxBool isInitialized = false.obs; // Track if the speech recognition is initialized

  // Initialize speech-to-text
  Future<void> initializeSpeech() async {
    if (!isInitialized.value) {  // Check if it has been initialized before
      bool available = await speech.initialize();
      if (available) {
        isInitialized.value = true;  // Set initialization flag to true
      } else {
        print('Speech recognition not available');
      }
    }
  }

  // Start listening to the microphone
  void startListening() async {
    // Initialize speech-to-text first if not already done
    if (!isInitialized.value) {
      await initializeSpeech();
    }

    // Start listening if initialization is successful
    if (isInitialized.value) {
      isListening.value = true;
      speech.listen(onResult: (result) {
        recognizedText.value = result.recognizedWords;
      });
    }
  }

  // Stop listening to the microphone
  void stopListening() {
    speech.stop();
    isListening.value = false;
  }
}

class SpeechToTextWidget extends StatelessWidget {
  final SpeechController speechController = Get.put(SpeechController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech to Text"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display recognized text
            Obx(() {
              return Text(
                speechController.recognizedText.value.isEmpty
                    ? 'Say something...'
                    : speechController.recognizedText.value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            }),

            // Microphone Icon Button to start/stop listening
            IconButton(
              icon: Icon(
                speechController.isListening.value ? Icons.mic_off : Icons.mic,
                color: Colors.blue,
              ),
              onPressed: () {
                if (speechController.isListening.value) {
                  speechController.stopListening();
                } else {
                  speechController.startListening();
                }
              },
              padding: EdgeInsets.all(12),
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SpeechToTextWidget(),
  ));
}
