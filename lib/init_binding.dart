import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:hive_app/connection_controller/connection_controller.dart';

class InitBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<Connectivity>(Connectivity(), permanent: true);
    Get.put<ConnectionService>(ConnectionService(Get.find<Connectivity>()), permanent: true);
  }
}