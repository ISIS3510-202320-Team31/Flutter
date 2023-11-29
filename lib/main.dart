import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_app/firebase_options.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/utils/time_calculator.dart';
import 'package:hive_app/view/pages/Login.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'init_binding.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Agrega esta línea para inicializar la internacionalización de fechas
  await initializeDateFormatting();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
      
    runApp(GetMaterialApp( // Cambia a GetMaterialApp
      title: "HIVE",
      initialRoute: '/Login',
      localizationsDelegates: 
      [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
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
