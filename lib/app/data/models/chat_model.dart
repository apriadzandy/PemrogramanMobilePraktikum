// lib/app/data/models/chat_model.dart
class ChatContact {
  final String contactName;
  final List<ChatMessage> messages;

  ChatContact({
    required this.contactName,
    required this.messages,
  });
}

class ChatMessage {
  final String sender;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
  });
}
