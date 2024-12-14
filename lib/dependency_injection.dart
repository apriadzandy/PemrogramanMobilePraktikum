import 'package:laund/app/modules/connection/bindings/connection_binding.dart';

class DependencyInjection {
  static void init() {
    ConnectionBinding().dependencies(); // Menginisialisasi binding ConnectionController
  }
}
