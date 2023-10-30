import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_app/firebase_options.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/utils/time_calculator.dart';
import 'package:hive_app/view/pages/Login.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MaterialApp(
            //home: Home(),
            theme: appTheme,
            title: "HIVE",
            initialRoute: '/Login',
            routes: {'/Login': (BuildContext context) => Login()},
          )));
  tiempo();
}

void tiempo() async {
  await saveInstallationTime();
}
  
  