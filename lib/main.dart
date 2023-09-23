import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/utils/time_calculator.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/view/pages/Login.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).
  then((_) => 
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: appTheme,
    title: "HIVE",
    initialRoute: '/Login', // '/Users',
    routes: {
      '/Feed': (BuildContext context) => Home(),
      '/Login': (BuildContext context) => Login()
    },
  )));
  tiempo();
}

void tiempo() async {
  await saveInstallationTime();
}
