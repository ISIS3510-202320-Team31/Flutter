import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_app/firebase_options.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/utils/time_calculator.dart';
import 'package:hive_app/view/pages/Login.dart';

import 'init_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(GetMaterialApp( // Cambia a GetMaterialApp
      title: "HIVE",
      initialRoute: '/Login',
      getPages: [
        GetPage(
          name: '/Login',
          page: () => Login(),
        ),
      ],
      initialBinding: InitBindings(),
      theme: appTheme,
    ));
  });

  tiempo();
}

void tiempo() async {
  await saveInstallationTime();
}
  
  