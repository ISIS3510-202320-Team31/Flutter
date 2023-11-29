import 'package:flutter/material.dart';
import 'package:hive_app/utils/Cache.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Stats.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';
import 'package:hive_app/utils/time_calculator.dart';
import 'package:hive_app/view_model/user.vm.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/utils/SecureStorage.dart';
import 'package:hive_app/view/pages/Login.dart';
import 'package:hive_app/view/widgets/OfflineWidget.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_app/view/widgets/BeeWrapper.dart';

class Profile extends StatefulWidget {
  final String userId;

  const Profile({required this.userId});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final sharedPreferences = SharedPreferences.getInstance();
  final SecureStorage secureStorage = SecureStorage();
  final UserVM _userVM = UserVM();
  String _name = cache.read("signup-name") ?? "0";
  String _email = cache.read("signup-email") ?? "0";
  String _timeOnApp = cache.read("time-on-app") ?? "0";
  String _eventsJoined = cache.read("events-joined") ?? "0";

  @override
  void initState() {
    _userVM.getUserById(widget.userId);
    _userVM.getParticipationById(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(userId: widget.userId)),
        );
        return true;
      },
      child: FutureBuilder<Duration>(
        future: calculateTimeSinceInstallation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final timeSinceInstallation = snapshot.data;
            return BeeWrapper(
              childBuilder: (toggleBeeFollowing) => Stack(
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
                              imageCallback: toggleBeeFollowing,
                            ),
                            Card(
                              margin: EdgeInsets.only(
                                  left: 10.0, right: 10.0, bottom: 10, top: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 8,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 15,
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
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                              );
                                            case Status.COMPLETED:
                                              if (_name != "0" &&
                                                  _email != "0" &&
                                                  _timeOnApp != "0" &&
                                                  _eventsJoined != "0") {
                                                cache.write(
                                                    "time-on-app",
                                                    formatTime(
                                                        timeSinceInstallation!));
                                                cache.write(
                                                    "events-joined",
                                                    viewModel.participation.data
                                                        .toString());
                                                _timeOnApp =
                                                    cache.read("time-on-app");
                                                _eventsJoined =
                                                    cache.read("events-joined");
                                              } else {
                                                cache.write("signup-name",
                                                    viewModel.user.data!.name);
                                                cache.write("signup-email",
                                                    viewModel.user.data!.email);
                                                cache.write(
                                                    "time-on-app",
                                                    formatTime(
                                                        timeSinceInstallation!));
                                                cache.write(
                                                    "events-joined",
                                                    viewModel.participation.data
                                                        .toString());
                                                _name =
                                                    cache.read("signup-name");
                                                _email =
                                                    cache.read("signup-email");
                                                _timeOnApp =
                                                    cache.read("time-on-app");
                                                _eventsJoined =
                                                    cache.read("events-joined");
                                              }
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .account_circle_rounded,
                                                      size: 150,
                                                    ),
                                                    SizedBox(
                                                      height: 22,
                                                    ),
                                                    Text(
                                                      'Nombre:',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '$_name\n',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Correo:',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '$_email\n',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Tiempo usado en la App:',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '$_timeOnApp\n',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Eventos a los que perteneces:',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      '$_eventsJoined eventos.\n',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            case Status.ERROR:
                                              return Text(
                                                'Estamos presentando errores...\nIntenta refrescar',
                                                style: TextStyle(fontSize: 20),
                                              );
                                            case Status.OFFLINE:
                                              if (_name != "0" &&
                                                  _email != "0" &&
                                                  _timeOnApp != "0" &&
                                                  _eventsJoined != "0") {
                                                return Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Icon(
                                                        Icons.signal_wifi_off,
                                                        size: 100,
                                                        color: Colors.grey,
                                                      ),
                                                      Text(
                                                        "Sin conexión a Internet.\nLos datos que ves no\nestán actualizados.",
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        'Nombre:',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        '$_name\n',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Correo:',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        '$_email\n',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Tiempo usado en la App:',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        '$_timeOnApp\n',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Eventos a los que perteneces:',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        '$_eventsJoined eventos\n',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return OfflineWidget();
                                              }
                                            default:
                                              return Container();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // remove all the information in local storage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Stats(),
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
                                  'Mis estadísticas',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // remove all the information in local storage
                                secureStorage.flushSecureData();
                                sharedPreferences.then((value) {
                                  value.clear();
                                });
                                cache.flush();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[700],
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
              ),
            );
          }
        },
      ),
    );
  }
}

String formatTime(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  return '$hours horas, $minutes minutos';
}
