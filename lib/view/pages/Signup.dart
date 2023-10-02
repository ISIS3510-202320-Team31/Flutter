import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/view/pages/Login.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupForm(),
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
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
              padding: EdgeInsets.all(20),
              child:Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingrese su usuario';
                        }
                        return null;
                      },
                    ),
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
                      decoration: InputDecoration(labelText: 'Contraseña'),
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
                              borderRadius: BorderRadius.circular(20.0), // Ajusta el valor de acuerdo a tu preferencia
                            ),
                          ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: Text('Iniciar Sesión'),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text('¿Ya tienes una cuenta? Inicia sesión'),
                    ),
                  ],
                ),
              )
              )
            ),
            ],
          ),
        ],
      ),
    );
  }
}
