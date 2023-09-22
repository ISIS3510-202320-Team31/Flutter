import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/utils/time_calculator.dart';
import 'package:hive_app/view/pages/Feed.dart';
import 'package:hive_app/view/pages/Home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: appTheme,
    title: "HIVE",
    initialRoute: '/Feed', // '/Users',  
    routes: {'/Feed': (BuildContext context ) => Home() }, // {'/Login': (BuildContext context ) => Login() },   
     
  ));
  tiempo();
}

void tiempo() async{
  await saveInstallationTime();
}