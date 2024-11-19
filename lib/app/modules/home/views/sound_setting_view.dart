import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/voice_controller.dart'; // Ensure proper import

class SoundSettingView extends StatelessWidget {
  final VoiceController voiceController = Get.put(VoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sound Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Voice:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildRadioOption('Default Voice', 'default'),
            _buildRadioOption('Robot Voice', 'robot'),
            _buildRadioOption('Female Voice', 'female'),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, String value) {
    return Obx(() {
      return ListTile(
        title: Text(label),
        leading: Radio<String>(
          value: value,
          groupValue: voiceController.currentVoice.value,
          onChanged: (String? newValue) {
            if (newValue != null) {
              voiceController.changeVoice(newValue);
            }
          },
        ),
      );
    });
  }
}
