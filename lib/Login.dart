import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_app/main.dart';
import 'dart:convert';


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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
      ),
      body: Form(
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
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, ingrese su contraseña';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Aquí puedes realizar la autenticación o procesar los datos del formulario
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  var url = Uri.parse('http://34.125.226.119:8080/users/');
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
                  var response = await http.post(url, body: jsonData);
                  // Lógica de autenticación aquí
                  print(response);
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNav()),
                  );
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
