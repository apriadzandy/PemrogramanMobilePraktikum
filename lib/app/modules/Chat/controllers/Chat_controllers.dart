import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChatController extends GetxController {
  var messages = [].obs;
  var messageController = TextEditingController();

  // Fungsi untuk memilih media (gambar atau video)
  Future<void> pickMedia() async {
    final picker = ImagePicker();

    // Pilih jenis media (gambar atau video)
    final mediaType = await showDialog<MediaType>(
      context: Get.context!,
      builder: (_) => AlertDialog(
        title: Text("Pilih Jenis Media"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: MediaType.image),
            child: Text("Gambar"),
          ),
          TextButton(
            onPressed: () => Get.back(result: MediaType.video),
            child: Text("Video"),
          ),
        ],
      ),
    );

    if (mediaType == null) return;

    // Pilih sumber media (kamera atau galeri)
    final mediaSource = await showDialog<ImageSource>(
      context: Get.context!,
      builder: (_) => AlertDialog(
        title: Text("Pilih Sumber Media"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: ImageSource.camera),
            child: Text("Kamera"),
          ),
          TextButton(
            onPressed: () => Get.back(result: ImageSource.gallery),
            child: Text("Galeri"),
          ),
        ],
      ),
    );

    if (mediaSource == null) return;

    // Pilih media berdasarkan tipe dan sumber
    final XFile? mediaFile = mediaType == MediaType.image
        ? await picker.pickImage(source: mediaSource)
        : await picker.pickVideo(source: mediaSource);

    if (mediaFile != null) {
      await uploadMedia(File(mediaFile.path), mediaType);
    }
  }

  // Fungsi untuk meng-upload gambar atau video ke Firebase Storage
  Future<void> uploadMedia(File mediaFile, MediaType mediaType) async {
    try {
      String fileName = basename(mediaFile.path);
      Reference storageRef = FirebaseStorage.instance.ref().child('chat_media/$fileName');

      // Meng-upload file ke Firebase Storage
      UploadTask uploadTask = storageRef.putFile(mediaFile);
      TaskSnapshot snapshot = await uploadTask;

      // Mendapatkan URL file setelah berhasil di-upload
      String fileUrl = await snapshot.ref.getDownloadURL();

      // Kirimkan pesan dengan URL media
      sendMessage(fileUrl, mediaType);
    } catch (e) {
      print("Error uploading media: $e");
    }
  }

  // Fungsi untuk mengirim pesan
  void sendMessage(String message, MediaType? mediaType) async {
    if (message.trim().isNotEmpty) {
      FirebaseFirestore.instance.collection('chats').doc('chatRoomId').collection('messages').add({
        'senderId': 'userId', // Gantilah dengan ID pengguna yang sedang login
        'message': message,
        'type': mediaType?.toString().split('.').last ?? 'text', // 'text' jika mediaType null
        'timestamp': FieldValue.serverTimestamp(),
      });
      messageController.clear();
    }
  }

  // Fungsi untuk mengambil pesan dari Firebase
  void fetchMessages(String chatRoomId) async {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}

// Enum untuk tipe media
enum MediaType {
  image,
  video,
}
