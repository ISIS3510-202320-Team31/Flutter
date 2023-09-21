import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';

//import 'package:hive_app/view/pages/Login.dart';
import 'package:hive_app/view/pages/Users.dart';
import 'package:hive_app/view/widgets/NavBar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BottomNav(),
    theme: appTheme,
    title: "HIVE",
    initialRoute: '/Users', // '/Users',  
    routes: {'/Users': (BuildContext context ) => Users() }, // {'/Login': (BuildContext context ) => Login() },    
  ));
}