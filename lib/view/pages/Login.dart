import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_app/services/notification_services.dart';
import 'package:http/http.dart' as http;
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/view/pages/Signup.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String lat = '';
  String long = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  appTheme.primaryColor,
                  appTheme.secondaryHeaderColor
                ], // Cambia estos colores según tus preferencias
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                width: 100,
                height: 250,
                child: Image.asset('assets/images/HIVE_LOGO_small.png'),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          20), // Esto agrega un margen inferior de 20 píxeles
                  child: Text(
                    "HIVE!",
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.7),
                          offset: Offset(2, 3),
                          blurRadius: 12,
                        )
                      ],
                      fontSize: 50, // Tamaño de fuente deseado
                      fontFamily: "Jost", // Fuente deseada
                      fontWeight:
                          FontWeight.bold, // Peso de la fuente en negrita
                      color: Colors.black, // Color del texto (opcional)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10, top: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 8,
                  child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingrese su email';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration:
                                  InputDecoration(labelText: 'Contraseña'),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingrese su contraseña';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Ajusta el valor de acuerdo a tu preferencia
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Aquí puedes realizar la autenticación o procesar los datos del formulario
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  var url = Uri.parse(
                                      'http://34.125.226.119:8080/users/');
                                  final Map<String, dynamic> datos = {
                                    'icon': 'icon',
                                    'login': 'login',
                                    'name': 'nombre',
                                    'verificated': true,
                                    'role': 'STUDENT',
                                    'career': 'DERECHO',
                                    'birthdate': '2002-12-27',
                                    'email': email,
                                    'password': password,
                                  };
                                  final jsonData = jsonEncode(datos);
                                  var response =
                                      await http.post(url, body: jsonData);
                                  // Lógica de autenticación aquí
                                  print(response);
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              },
                              child: Text('Iniciar Sesión',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            SizedBox(height: 10),
                            // other kind of button
                            TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()),
                                );
                              },
                              child: Text('¿No tienes una cuenta? Regístrate'),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ],
      ),
    );
  }

  void handleNotification() async {
  _getCurrentLocation().then((value) {
    lat = '${value.latitude}';
    long = '${value.longitude}';
    _liveLocation();
    double latDouble = double.tryParse(lat) ?? 0.0;
    double longDouble = double.tryParse(lat) ?? 0.0;
    if (latDouble < 4.605 && latDouble > 4.598 && longDouble > -74.06 && longDouble < -74.0677) {
      initNotifications();
      showNotification("en la Universidad de Los Andes,");
    } else {
      initNotifications();
      showNotification("por fuera de UniAndes, pero");
    }
  });
}

  void _liveLocation(){
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 50,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled){
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permissions are denied');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error(
        'Location permissions are permanently denied, we cannot request permission.'
      );
    }
    return await Geolocator.getCurrentPosition();
  }
}
