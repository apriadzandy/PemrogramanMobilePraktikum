import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/identify_controller.dart';


class ChatView extends StatelessWidget {
  final String laundryName;
  final IdentifyController identifyController = Get.put(IdentifyController());

  ChatView({required this.laundryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(laundryName, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        return identifyController.isIdentityFilled.value ? _buildChat() : _buildIdentityForm();
        //jika identitas terisi, tampilkan chat. jika tidak, tampilkan form
      }),
    );
  }

  Widget _buildIdentityForm() { //membuat form
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: identifyController.nameController,
            decoration: InputDecoration(labelText: 'Nama', border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          TextField(
            controller: identifyController.phoneController,
            decoration: InputDecoration(labelText: 'Nomor Telepon', border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          TextField(
            controller: identifyController.addressController,
            decoration: InputDecoration(labelText: 'Alamat', border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          ElevatedButton( //mengirim data identitas ke controller jika ditekan
            onPressed: identifyController.submitIdentity,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildChat() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: identifyController.messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(identifyController.messages[index], style: TextStyle(color: Colors.blue[800])),
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
                  controller: identifyController.messageController,
                  decoration: InputDecoration(
                    hintText: 'Ketik pesan...',
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    filled: true,
                    fillColor: Colors.blue[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue),
                onPressed: identifyController.sendMessage,
                padding: EdgeInsets.all(12),
                iconSize: 30,
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: identifyController.showIdentity,
          child: Text('Read Identity'),
        ),
      ],
    );
  }
}