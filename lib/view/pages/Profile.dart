import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/ViewsHeader.dart';
import 'package:hive_app/utils/time_calculator.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Duration>(
      future: calculateTimeSinceInstallation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras se obtiene el tiempo.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Maneja los errores si los hubiera.
          return Text('Error: ${snapshot.error}');
        } else {
          final timeSinceInstallation = snapshot.data;

          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        ViewsHeader(
                          titleText: "Tiempo desde la instalación",
                        ),
                        Text(
                          'Tiempo desde la instalación: ${formatTime(timeSinceInstallation!)}', //Supongo que no es Nulo, por eso el "!".
                          style: TextStyle(fontSize: 18),
                        ),
                        // Otros elementos de perfil...
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
