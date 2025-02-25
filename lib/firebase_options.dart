// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBl752XPcaUV9CjJ6gR1bpOflpql61KqM0',
    appId: '1:957694801163:web:a1a56d3294abd694055e0e',
    messagingSenderId: '957694801163',
    projectId: 'laundryaplication-bd165',
    authDomain: 'laundryaplication-bd165.firebaseapp.com',
    storageBucket: 'laundryaplication-bd165.appspot.com',
    measurementId: 'G-H7D8VGTW93',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKFPqiKnsfmwMta_q6KexaTI3EzsDwi9U',
    appId: '1:957694801163:android:519c1bbc3dca2d27055e0e',
    messagingSenderId: '957694801163',
    projectId: 'laundryaplication-bd165',
    storageBucket: 'laundryaplication-bd165.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAi5tFRj8rtzRGtlE72y4U8UOpPDi9NrYo',
    appId: '1:957694801163:ios:be46ee213942772a055e0e',
    messagingSenderId: '957694801163',
    projectId: 'laundryaplication-bd165',
    storageBucket: 'laundryaplication-bd165.appspot.com',
    iosBundleId: 'com.example.laund',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAi5tFRj8rtzRGtlE72y4U8UOpPDi9NrYo',
    appId: '1:957694801163:ios:be46ee213942772a055e0e',
    messagingSenderId: '957694801163',
    projectId: 'laundryaplication-bd165',
    storageBucket: 'laundryaplication-bd165.appspot.com',
    iosBundleId: 'com.example.laund',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBl752XPcaUV9CjJ6gR1bpOflpql61KqM0',
    appId: '1:957694801163:web:b952e396ee1344df055e0e',
    messagingSenderId: '957694801163',
    projectId: 'laundryaplication-bd165',
    authDomain: 'laundryaplication-bd165.firebaseapp.com',
    storageBucket: 'laundryaplication-bd165.appspot.com',
    measurementId: 'G-5Z6WCMGK3H',
  );
}
