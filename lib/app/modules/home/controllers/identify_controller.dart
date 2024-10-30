import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IdentifyController extends GetxController {
  var isIdentityFilled = false.obs; //mengecek identitas pengguna terisi atau belum
  var messages = <String>[].obs; //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(); 
  final TextEditingController addressController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  //texteditingcontrolller mengambil nilai, memodifikasi, dan memberi tahu widget jika ada perubahan

  String? userDocumentId;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    //data masuk ke collection customer
    final QuerySnapshot result = await FirebaseFirestore.instance.collection('customer').get();

    if (result.docs.isNotEmpty) { //memastikan ada dokumen di Firestore atau tidak
      var userData = result.docs.first.data() as Map<String, dynamic>;
      userDocumentId = result.docs.first.id;
      nameController.text = userData['name'] ?? '';
      phoneController.text = userData['phone'] ?? '';
      addressController.text = userData['address'] ?? '';
      isIdentityFilled.value = true; //identitas pengguna berhasil  diisi
    }
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      messages.add('${nameController.text}: ${messageController.text}');
      messageController.clear();
    }
  }

  Future<void> saveToFirestore() async {
    final customerData = {
      'name': nameController.text,
      'phone': phoneController.text,
      'address': addressController.text,
    };

    try {
      if (userDocumentId == null) { //mengecek user sudah ada documentID apa belum
        DocumentReference docRef = await FirebaseFirestore.instance.collection('customer').add(customerData);
        //user baru belum ada documentID maka ditambah ke koleksi customer
        userDocumentId = docRef.id;
      } else {
        await FirebaseFirestore.instance.collection('customer').doc(userDocumentId).set(customerData, SetOptions(merge: true)); 
        //menggabungkan data baru dan lama
      }
    } catch (e) {
      print('Gagal menyimpan data: $e');
    }
  }

  void submitIdentity() {
    isIdentityFilled.value = true;
    saveToFirestore();
  }

  void showIdentity() {
    Get.defaultDialog(
      title: 'Identitas Pengguna',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nama: ${nameController.text}'),
          Text('Nomor Telepon: ${phoneController.text}'),
          Text('Alamat: ${addressController.text}'),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Close')), //menutup dialog, kembali ke tampilan sebelumnya
        TextButton(onPressed: () => updateIdentity(), child: Text('Edit')), //memperbaruhi identitas
        TextButton(onPressed: () => deleteFromFirestore(), child: Text('Delete')), //menghapus identitas firebase
      ],
    );
  }

  void updateIdentity() {
    Get.defaultDialog(
      title: 'Perbarui Identitas',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nama', border: OutlineInputBorder())),
          SizedBox(height: 10),
          TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Nomor Telepon', border: OutlineInputBorder())),
          SizedBox(height: 10),
          TextField(controller: addressController, decoration: InputDecoration(labelText: 'Alamat', border: OutlineInputBorder())),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            isIdentityFilled.value = true; //identitas telah terisi kembali
            saveToFirestore(); //menyimpan ke firebase
            Get.back();
          },
          child: Text('Simpan'),
        ),
        TextButton(onPressed: () => Get.back(), child: Text('Batal')),
      ],
    );
  }

  Future<void> deleteFromFirestore() async {
    if (userDocumentId != null) {
      try {
        await FirebaseFirestore.instance.collection('customer').doc(userDocumentId).delete();
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        isIdentityFilled.value = false;
        userDocumentId = null;
      } catch (e) {
        print('Gagal menghapus data: $e');
      }
    }
  }
}