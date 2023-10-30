import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxController{
  late Connectivity _connectivity;

  ConnectionService(this._connectivity);

  RxBool isConnected = true.obs;
  StreamSubscription? subscription;

  void listenToNetworkChanges(){
    subscription = _connectivity.onConnectivityChanged.listen((connectivityResult)
     {
      if(connectivityResult == ConnectivityResult.mobile){
        isConnected.value = true;
        log("Ahora, hay conexion Wifi!");
      } else if (connectivityResult == ConnectivityResult.wifi){
        isConnected.value = true;
        
        log("Ahora, hay conexion Wifi!");

      } else {
        isConnected.value = false;
        log("Ahora, NO hay conexion Wifi.");
      }
    });
  }

  @override
  void onClose(){
    subscription!.cancel();
    super.onClose();
  }
}