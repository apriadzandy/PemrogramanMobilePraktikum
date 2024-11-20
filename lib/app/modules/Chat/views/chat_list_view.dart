import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/Chat/controllers/Chat_controllers.dart';
import 'package:laund/app/modules/Chat/views/chat_detail_view.dart';

class ChatListView extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController()); // Inisialisasi ChatController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent, // Warna biru
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('chats').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var chatRooms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              var chatRoom = chatRooms[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16), // Padding untuk ListTile
                  title: Text(
                    'Chat with ${chatRoom['users']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue[800], // Warna teks
                    ),
                  ),
                  subtitle: Text(
                    'Last message: ${chatRoom['lastMessage'] ?? 'No messages yet'}',
                    style: TextStyle(color: Colors.grey[600]), // Warna teks untuk subtitle
                  ),
                  onTap: () {
                    Get.to(ChatDetailView(chatRoomId: chatRooms[index].id)); // Arahkan ke ChatDetailView
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}