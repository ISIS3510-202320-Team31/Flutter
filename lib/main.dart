import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';

//import 'package:hive_app/view/pages/Login.dart';
import 'package:hive_app/view/pages/Feed.dart';
import 'package:hive_app/view/widgets/NavBar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BottomNav(),
    theme: appTheme,
    title: "HIVE",
    initialRoute: '/Feed', // '/Users',  
    routes: {'/Feed': (BuildContext context ) => Feed() }, // {'/Login': (BuildContext context ) => Login() },    
  ));
}