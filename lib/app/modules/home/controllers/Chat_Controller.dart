import 'package:get/get.dart';

class ChatController extends GetxController {
  // Daftar laundry yang bisa dijadikan chat
  var laundryList = <String>[
    'Ida Laundry',
    'Budi Laundry',
    'Citra Laundry',
    'Sinar Laundry',
  ].obs; // Gunakan .obs untuk menjadikannya observable
}
