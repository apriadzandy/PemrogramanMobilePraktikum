import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import 'chat_view.dart'; // Pastikan mengimpor ChatView

class ChatListView extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController()); // Inisialisasi ChatController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Chat Laundry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Judul yang lebih menonjol
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
      ),
      body: Container(
        color: Colors.white, // Background body putih
        padding: const EdgeInsets.all(16.0), // Padding di sekitar body
        child: Obx(() {
          return ListView.builder(
            itemCount: chatController.laundryList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4, // Memberikan efek bayangan pada card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Sudut melengkung pada card
                ),
                margin: const EdgeInsets.symmetric(vertical: 8), // Margin antar card
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16), // Padding di dalam ListTile
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          chatController.laundryList[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, // Warna teks biru
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chat, // Ikon chat
                        color: Colors.blue, // Warna ikon
                      ),
                    ],
                  ),
                  onTap: () {
                    // Arahkan ke ChatView ketika laundry dipilih
                    Get.to(ChatView(laundryName: chatController.laundryList[index]));
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
