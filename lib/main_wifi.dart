import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_app/connection_controller/connection_controller.dart';

class MainWifi extends StatefulWidget{
  MainWifi({super.key});

  @override
  State<MainWifi> createState() => _MainWifiState();
}

class _MainWifiState extends State<MainWifi> {
late ConnectionService _connectionService;

  @override
  void initState(){
    _connectionService = Get.find<ConnectionService>();

    _connectionService.listenToNetworkChanges(context);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}