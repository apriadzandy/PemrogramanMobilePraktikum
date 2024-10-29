import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final String laundryName;

  ChatView({required this.laundryName});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<String> messages = []; // Daftar pesan yang akan ditampilkan
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add(_messageController.text); // Menambahkan pesan baru ke daftar
        _messageController.clear(); // Menghapus teks yang dimasukkan
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Warna AppBar biru
        title: Text(
          widget.laundryName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // Warna latar belakang pesan
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      messages[index],
                      style: TextStyle(color: Colors.blue[800]), // Warna teks pesan
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      hintStyle: TextStyle(color: Colors.blueGrey), // Warna teks hint
                      filled: true,
                      fillColor: Colors.blue[50], // Warna latar belakang TextField
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none, // Menghilangkan garis tepi
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.white), // Warna ikon
                  onPressed: _sendMessage, // Mengirim pesan saat tombol ditekan
                  color: Colors.blue, // Warna latar belakang tombol
                  padding: EdgeInsets.all(12), // Ukuran padding
                  iconSize: 30, // Ukuran ikon
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
