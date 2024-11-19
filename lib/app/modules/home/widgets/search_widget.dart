import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/speech_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  // Initialize SpeechController
  final SpeechController speechController = Get.put(SpeechController());

  SearchWidget({required this.searchController, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Row to show text field and microphone button
          Row(
            children: [
              // Text field for manual search input
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    onSearch(value);  // Function to perform search
                  },
                ),
              ),
              SizedBox(width: 10), // Add some space between text field and mic icon
              IconButton(
                icon: Icon(
                  speechController.isListening.value ? Icons.mic_off : Icons.mic,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  if (speechController.isListening.value) {
                    // If already listening, stop it
                    speechController.stopListening();
                  } else {
                    // Start listening if not already
                    speechController.startListening();
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          // Display the recognized text (speech-to-text result)
          Obx(() {
            // Use WidgetsBinding to update the controller after build
            if (speechController.recognizedText.value != searchController.text) {
              // Delay the update to prevent the error during build
              WidgetsBinding.instance.addPostFrameCallback((_) {
                searchController.text = speechController.recognizedText.value;
                // Keep the cursor at the end of the text after update
                searchController.selection = TextSelection.fromPosition(
                  TextPosition(offset: searchController.text.length),
                );
              });
            }

            return SizedBox(); // We do not need to return additional text here
          }),
        ],
      ),
    );
  }
}
