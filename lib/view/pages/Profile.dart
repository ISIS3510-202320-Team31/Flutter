import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';
import 'package:hive_app/utils/time_calculator.dart';

class Profile extends StatelessWidget {
  final String userId;
  const Profile({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Duration>(
      future: calculateTimeSinceInstallation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final timeSinceInstallation = snapshot.data;
          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      appTheme.primaryColor,
                      appTheme.secondaryHeaderColor
                    ],
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
                          titleText: "Perfil",
                        ),
                        // Imagen
                        (Image.asset(
                          'assets/images/Profile.jpg',
                          width: 200,
                          height: 200,
                        )),
                        // Espacio entre la imagen y el texto
                        (SizedBox(
                          height: 30,
                        )),
                        Text(
                          'Correo:\n'
                          'ne.rueda@uniandes.edu.co\n\n'
                          'Tiempo usado en la App:\n'
                          '${formatTime(timeSinceInstallation!)}\n\n'
                          'Eventos a los que perteneces:\n'
                          '6 eventos.\n\n\n',
                          style: TextStyle(fontSize: 20),
                        ),
                        ElevatedButton(
                          onPressed: handleLogOut,
                          child: Text('Cerrar sesion'),
                        ),
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

String formatTime(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  return '$hours horas, $minutes minutos';
}

void handleLogOut() async {
  //TODO
  print('Se oprimió el botón de cerrar sesión');
}
