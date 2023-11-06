import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxController{
  late Connectivity _connectivity;

  ConnectionService(this._connectivity);

  RxBool isConnected = true.obs;
  StreamSubscription? subscription;

  void listenToNetworkChanges() {
    subscription = _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile) {
        isConnected.value = true;
        Get.snackbar("Conexión restablecida", "Ahora hay conexión móvil");
      } else if (connectivityResult == ConnectivityResult.wifi) {
        isConnected.value = true;
        Get.snackbar("Conexión restablecida", "Ahora hay conexión Wifi");
      } else {
        isConnected.value = false;
        Get.snackbar("Conexión perdida", "No hay conexión Wifi");
      }
    });
  }

  @override
  void onClose(){
    subscription!.cancel();
    super.onClose();
  }
}