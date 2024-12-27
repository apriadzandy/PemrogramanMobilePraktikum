import 'package:get/get.dart';
import 'package:laund/app/modules/Login_Register/views/login_view.dart';
import 'package:laund/app/modules/home/views/main_view.dart';
import 'package:laund/splash_screen.dart'; // Pastikan MainView sudah ada


part 'app_routes.dart';

abstract class AppPages {
  AppPages._();
 // Tambahkan constant baru
  static const LOGIN = _Paths.LOGIN;
  static const MAIN = _Paths.MAIN;
  static const SPLASH = _Paths.SPLASH;

  static final routes = [
  
    GetPage(name: LOGIN, page: () => LoginPage()),
    GetPage(name: MAIN, page: () => MainView()),
    GetPage(name: SPLASH, page: () => SplashScreen()),
  ];
  
}

abstract class _Paths {
  _Paths._();
  static const LOGIN = '/login';
  static const MAIN = '/main';
  static const SPLASH = '/splash';
}
