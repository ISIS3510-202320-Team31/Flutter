import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/view/pages/Signup.dart';
import 'package:hive_app/view_model/user.vm.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/utils/SecureStorage.dart';

class Login extends StatelessWidget {
  final String? redirection;
  const Login({this.redirection});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginForm(redirection: redirection),
    );
  }
}

class LoginForm extends StatefulWidget {
  final String? redirection;
  const LoginForm({this.redirection});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final SecureStorage secureStorage = SecureStorage();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _validationError = "";

  final UserVM userVM = UserVM();

  @override
  Widget build(BuildContext context) {
    print("Redirection: ${widget.redirection}");
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
              // if redirected from signup, show a success message
              if (widget.redirection == 'signup')
                Container(
                    child: Text(
                      '¡Registro exitoso!',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(2, 3),
                            blurRadius: 12,
                          )
                        ],
                        fontSize: 18, // Tamaño de fuente deseado
                        fontFamily: "Jost", // Fuente deseada
                        fontWeight:
                            FontWeight.bold, // Peso de la fuente en negrita
                        color: Colors.black, // Color del texto (opcional)
                      ),
                    ),
                    alignment: Alignment.center),

              // if redirected from signup, show a success message
              if (widget.redirection == 'signup')
                Container(
                    child: Text(
                      'Ingresa tus credenciales',
                      style: TextStyle(
                        fontSize: 14, // Tamaño de fuente deseado
                        fontFamily: "Jost", // Fuente deseada
                        fontWeight:
                            FontWeight.bold, // Peso de la fuente en negrita
                        color: Colors.black, // Color del texto (opcional)
                      ),
                    ),
                    alignment: Alignment.center),
              SizedBox(height: 10),
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
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  labelText: 'Nombre de usuario'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu nombre de usuario';
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
                            SizedBox(height: 20),
                            ChangeNotifierProvider<UserVM>(
                              create: (BuildContext context) => userVM,
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
                                                0.05,
                                      );
                                    case Status.ERROR:
                                      print("Log :: ERROR");
                                      return Container(
                                        width: double.infinity,
                                        child: Text(
                                          jsonDecode(viewModel.user.message!)[
                                              "message"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    case Status.COMPLETED:
                                      return Builder(
                                        builder: (context) {
                                          Future.delayed(
                                                  Duration(milliseconds: 100))
                                              .then((_) {
                                            secureStorage.writeSecureData(
                                                'userId',
                                                viewModel.user.data!.id!);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home(
                                                      userId: viewModel
                                                          .user.data!.id!)),
                                            );
                                          });
                                          return Container();
                                        },
                                      );
                                    default:
                                      return Container(
                                        width: double.infinity,
                                        child: Text(
                                          _validationError,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: _validationError == ""
                                                ? Colors.white
                                                : Colors.red,
                                          ),
                                        ),
                                      );
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                // Validation Step
                                // 1. Check that all fields are filled
                                if (!_formKey.currentState!.validate()) {
                                  setState(() {
                                    _validationError = "";
                                  });
                                  return;
                                }
                                // 2. Send to backend and wait for response, if response is error, show error message
                                setState(() {
                                  _validationError = "";
                                });
                                await userVM.login(_usernameController.text,
                                    _passwordController.text);
                              },
                              child: Text('INICIAR SESIÓN',
                                  style: TextStyle(fontSize: 15)),
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
}
