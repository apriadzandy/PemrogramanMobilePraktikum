import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:laund/app/modules/home/controllers/user_controller.dart';
import 'package:laund/app/routes/app_pages.dart';
import 'package:laund/app/modules/home/controllers/auth_controller.dart'; // Import AuthController
import 'package:laund/notification_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Mendaftarkan AuthController dan SettingController
  Get.put(AuthController());
  Get.put(UserController()); 

  // Inisialisasi notifikasi
  NotificationHandler notificationHandler = NotificationHandler();
  await notificationHandler.initPushNotification();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Set initial route ke halaman login
      getPages: AppPages.routes,
    );
  }
}
