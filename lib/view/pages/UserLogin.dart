import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  // Controladores para los campos de entrada
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Método para manejar la solicitud de inicio de sesión
  void handleLogin() {
    final String username = usernameController.text;
    final String password = passwordController.text;

    // Aquí puedes realizar la solicitud de inicio de sesión con los datos proporcionados
    // Por ejemplo, puedes utilizar una biblioteca de HTTP como 'http' o 'Dio' para realizar la solicitud.
    // Luego, puedes procesar la respuesta y tomar acciones en consecuencia.

    // Imprime los datos para demostración
    print('Usuario: $username');
    print('Contraseña: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Campo de entrada de nombre de usuario
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Usuario'),
          ),

          // Campo de entrada de contraseña
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true, // Oculta la contraseña
          ),

          // Botón de inicio de sesión
          ElevatedButton(
            onPressed: handleLogin,
            child: Text('Iniciar Sesión'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Limpia los controladores cuando se destruye el widget
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

