import 'package:get/get.dart';

class LaundryDetailController extends GetxController {
  var selectedInfo = ''.obs; // Untuk menyimpan info yang dipilih

  void selectInfo(String info) {
    selectedInfo.value = info; // Memperbarui info yang dipilih
  }
}
