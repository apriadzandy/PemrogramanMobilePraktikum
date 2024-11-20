import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/Chat/controllers/Chat_controllers.dart';
import 'package:laund/app/modules/Chat/widget/video_player_widget.dart';


class ChatDetailView extends StatelessWidget {
  final String chatRoomId;
  final ChatController chatController = Get.put(ChatController());

  ChatDetailView({Key? key, required this.chatRoomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    chatController.fetchMessages(chatRoomId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  var message = chatController.messages[index];
                  return _buildMessageBubble(message);
                },
              );
            }),
          ),
          _buildMessageInputArea(),
        ],
      ),
    );
  }

  AppBar _buildCustomAppBar() {
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://via.placeholder.com/150', 
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatRoomId, 
                style: TextStyle(
                  color: Colors.black87, 
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Text(
                'Online', 
                style: TextStyle(
                  color: Colors.green, 
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    bool isMe = message['senderId'] == 'currentUserId'; // Replace with actual logic

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: 
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) _buildSenderAvatar(message),
          Container(
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.7,
            ),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isMe ? Color(0xFF007AFF) : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: isMe ? Radius.circular(16) : Radius.zero,
                bottomRight: isMe ? Radius.zero : Radius.circular(16),
              ),
            ),
            child: _buildMessageContent(message, isMe),
          ),
        ],
      ),
    );
  }

  Widget _buildSenderAvatar(Map<String, dynamic> message) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          message['senderAvatar'] ?? 
          'https://via.placeholder.com/150',
        ),
      ),
    );
  }

  Widget _buildMessageContent(Map<String, dynamic> message, bool isMe) {
    Color textColor = isMe ? Colors.white : Colors.black87;

    switch (message['type']) {
      case 'text':
        return Text(
          message['message'],
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        );
      case 'image':
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            message['message'],
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CircularProgressIndicator(
                color: isMe ? Colors.white : Colors.blue,
              );
            },
          ),
        );
      case 'video':
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayerWidget(mediaUrl: message['message']),
        );
      default:
        return Text(
          'Unsupported message type',
          style: TextStyle(color: textColor),
        );
    }
  }

  Widget _buildMessageInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.add_a_photo, color: Colors.blue),
              onPressed: () async {
                await chatController.pickMedia();
              },
            ),
            Expanded(
              child: TextField(
                controller: chatController.messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: null,
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final message = chatController.messageController.text.trim();
    if (message.isNotEmpty) {
      chatController.sendMessage(message, null);
      chatController.messageController.clear();
    }
  }
}

