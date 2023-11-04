import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';
import 'package:hive_app/utils/time_calculator.dart';
import 'package:hive_app/view_model/user.vm.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/utils/SecureStorage.dart';
import 'package:hive_app/view/pages/Login.dart';
import 'package:hive_app/view/widgets/OfflineWidget.dart';

class Profile extends StatefulWidget {
  final String userId;

  const Profile({required this.userId});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final SecureStorage secureStorage = SecureStorage();
  final UserVM _userVM = UserVM();

  @override
  void initState() {
    _userVM.getUserById(widget.userId);
    _userVM.getParticipationById(widget.userId);
    super.initState();
  }

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
                      appTheme.secondaryHeaderColor,
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: ListView(
                      children: [
                        ViewsHeader(
                          titleText: "Perfil",
                        ),
                        // Cuadrado blanco
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                10), // Bordes redondeados de 10px
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black, // Color de la sombra
                                offset: Offset(0,
                                    2), // Desplazamiento de la sombra (eje X, eje Y)
                                blurRadius:
                                    2, // Radio de desenfoque de la sombra
                                spreadRadius:
                                    0, // Radio de extensión de la sombra
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(
                              20), // Espacio alrededor del cuadrado
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.account_circle_rounded,
                                size: 100,
                              ),
                              // Espacio entre la imagen y el texto
                              SizedBox(
                                height: 30,
                              ),
                              ChangeNotifierProvider(
                                create: (context) => _userVM,
                                child: Consumer<UserVM>(
                                    builder: (context, viewModel, _) {
                                  switch (viewModel.user.status) {
                                    case Status.LOADING:
                                      print("Log :: LOADING");
                                      return Container(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                      );
                                    case Status.COMPLETED:
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nombre:\n${viewModel.user.data!.name}\n\n'
                                            'Correo:\n${viewModel.user.data!.email}\n\n'
                                            'Tiempo usado en la App:\n${formatTime(timeSinceInstallation!)}\n\n'
                                            'Eventos a los que perteneces:\n${viewModel.participation.data} eventos.\n',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      );
                                    case Status.ERROR:
                                      return Text(
                                        'Estamos presentando errores en nuestro servidor, esperamos arreglarlos pronto... Intenta refrescar',
                                        style: TextStyle(fontSize: 20),
                                      );
                                    case Status.OFFLINE:
                                      return OfflineWidget();
                                    default:
                                      return Container();
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            secureStorage.deleteSecureData("userId");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shadowColor: Colors.black,
                            elevation: 6,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              'Cerrar sesión',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
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
