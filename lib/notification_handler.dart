// notification_handler.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Pesan diterima di background: ${message.notification?.title}');
}

class NotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();

  Future<void> initPushNotification() async {
    // Inisialisasi pengaturan untuk notifikasi lokal
    const AndroidInitializationSettings initializationSettingsAndroid = 
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = 
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Meminta izin notifikasi
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Izin yang diberikan pengguna: ${settings.authorizationStatus}');

    // Mendapatkan token FCM
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Menangani pesan saat aplikasi terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("Pesan saat aplikasi terminated: ${message.notification?.title}");
        // Tambahkan logika untuk menavigasi ke halaman tertentu
      }
    });

    // Menangani pesan saat aplikasi di background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Menangani pesan saat aplikasi di foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Pesan diterima di foreground: ${message.notification?.title}");
      if (message.notification != null) {
        _showForegroundNotification(message);
      }
    });
  }

  // Fungsi untuk menampilkan notifikasi di foreground menggunakan flutter_local_notifications
  void _showForegroundNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails = 
        AndroidNotificationDetails(
      'your_channel_id', // ID channel
      'your_channel_name', // Nama channel
      channelDescription: 'your_channel_description',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics = 
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }
}
