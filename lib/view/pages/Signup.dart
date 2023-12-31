import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_app/utils/Cache.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Login.dart';
import 'package:hive_app/view_model/user.vm.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/data/remote/response/Status.dart';

// create a final object for the dropdown list
final Map<String, String> _dropdownValues = {
  "Administración": "ADMINISTRACION",
  "Antropología": "ANTROPOLOGIA",
  "Arquitectura": "ARQUITECTURA",
  "Arte": "ARTE",
  "Biología": "BIOLOGIA",
  "Contaduría Internacional": "CONTADURIA_INTERNACIONAL",
  "Decanatura de Estudiantes": "DECANATURA_DE_ESTUDIANTES",
  "Deportes": "DEPORTES",
  "Derecho": "DERECHO",
  "Diseño": "DISENO",
  "Economía": "ECONOMIA",
  "Educación": "EDUCACION",
  "Filosofía": "FILOSOFIA",
  "Física": "FISICA",
  "Geociencias": "GEOCIENCIAS",
  "Escuela de Gobierno": "ESCUELA_DE_GOBIERNO",
  "Historia": "HISTORIA",
  "Historia del Arte": "HISTORIA_DEL_ARTE",
  "Ingeniería Biomédica": "INGENIERIA_BIOMEDICA",
  "Ingeniería Civil y Ambiental": "INGENIERIA_CIVIL_Y_AMBIENTAL",
  "Ingeniería de Alimentos": "INGENIERIA_DE_ALIMENTOS",
  "Ingeniería de Sistemas": "INGENIERIA_DE_SISTEMAS_Y_COMPUTACION",
  "Ingeniería Eléctrica y Electrónica": "INGENIERIA_ELECTRICA_Y_ELECTRONICA",
  "Ingeniería Industrial": "INGENIERIA_INDUSTRIAL",
  "Ingeniería Mecánica": "INGENIERIA_MECANICA",
  "Ingeniería Química": "INGENIERIA_QUIMICA",
  "Lenguas y Cultura": "LENGUAS_Y_CULTURA",
  "Literatura": "LITERATURA",
  "Matemáticas": "MATEMATICAS",
  "Medicina": "MEDICINA",
  "Microbiología": "MICROBIOLOGIA",
  "Música": "MUSICA",
  "Narrativas Digitales": "NARRATIVAS_DIGITALES",
  "Psicología": "PSICOLOGIA",
  "Química": "QUIMICA",
  "Otro": "OTRO"
};

final Map<int, String> _months = {
  1: "enero",
  2: "febrero",
  3: "marzo",
  4: "abril",
  5: "mayo",
  6: "junio",
  7: "julio",
  8: "agosto",
  9: "septiembre",
  10: "octubre",
  11: "noviembre",
  12: "diciembre"
};

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
  final GlobalKey<FormFieldState> nameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> usernameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> confirmpasswordKey =
      GlobalKey<FormFieldState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  String _career = "";
  DateTime? _selectedDate;
  String _validationError = "";

  final UserVM userVM = UserVM();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      cache.write("signup-birthdate", _selectedDate);
    }
  }

  @override
  void initState() {
    super.initState();
    _name.text = cache.read("signup-name") ?? "";
    _username.text = cache.read("signup-username") ?? "";
    _email.text = cache.read("signup-email") ?? "";
    _career = cache.read("signup-career") ?? "";
    _selectedDate = cache.read("signup-birthdate") ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              key: nameKey,
                              controller: _name,
                              decoration: InputDecoration(labelText: 'Nombre'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu nombre';
                                }
                                if (value.length > 70) {
                                  return 'El nombre no puede tener más de 70 caracteres';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                cache.write("signup-name", value);
                                nameKey.currentState!.validate();
                              },
                            ),
                            TextFormField(
                              key: usernameKey,
                              controller: _username,
                              decoration: InputDecoration(
                                  labelText: 'Nombre de usuario'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu nombre de usuario';
                                }
                                if (value.length > 20) {
                                  return 'No puede tener más de 20 caracteres';
                                }
                                // el nombre de usuario solo puede tener minusculas, _ y numeros
                                RegExp usernameRegex = RegExp(r"^[a-z0-9_]+$");
                                if (!usernameRegex.hasMatch(value)) {
                                  return 'Solo puede tener minúsculas, números y _';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                cache.write("signup-username", value);
                                usernameKey.currentState!.validate();
                              },
                            ),
                            TextFormField(
                              key: emailKey,
                              controller: _email,
                              decoration: InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu correo';
                                }
                                if (value.length > 30) {
                                  return 'El correo no puede tener más de 30 caracteres';
                                }
                                RegExp emailRegex = RegExp(
                                    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Por favor, ingresa un correo válido';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                cache.write("signup-email", value);
                                emailKey.currentState!.validate();
                              },
                            ),
                            TextFormField(
                              key: passwordKey,
                              controller: _password,
                              decoration:
                                  InputDecoration(labelText: 'Contraseña'),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu contraseña';
                                }
                                if (value.length > 60) {
                                  return 'La contraseña no puede tener más de 60 caracteres';
                                }
                                RegExp passwordRegex = RegExp(
                                    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
                                if (!passwordRegex.hasMatch(value)) {
                                  return "Debe tener: 8 caracteres, una mayúscula y un número";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                passwordKey.currentState!.validate();
                                confirmpasswordKey.currentState!.validate();
                              },
                            ),
                            TextFormField(
                              key: confirmpasswordKey,
                              controller: _confirmpassword,
                              decoration: InputDecoration(
                                  labelText: 'Confirmar contraseña'),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu contraseña de nuevo';
                                }
                                if (_password.text != value) {
                                  return "Las contraseñas no coinciden";
                                }
                                return null;
                                // this one should not be saved in cache
                              },
                              onChanged: (value) {
                                confirmpasswordKey.currentState!.validate();
                              },
                            ),
                            SizedBox(height: 30),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Departamento',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              items: _dropdownValues.keys
                                  .map((String key) => DropdownMenuItem(
                                        value: key,
                                        child: Text(key),
                                      ))
                                  .toList(),
                              value: _career == ""
                                  ? null
                                  : _dropdownValues.keys.firstWhere(
                                      (k) => _dropdownValues[k] == _career),
                              onChanged: (value) {
                                setState(() {
                                  _career = _dropdownValues[value]!;
                                  cache.write("signup-career", _career);
                                });
                              },
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Fecha de nacimiento',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () => _selectDate(context),
                              child: _selectedDate == null
                                  ? Padding(
                                      padding: EdgeInsets.all(
                                          10.0), // Adjust the padding as needed
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: Colors.black54,
                                      ),
                                    )
                                  : Text(
                                      '${_selectedDate!.day} de ${_months[_selectedDate!.month]} de ${_selectedDate!.year}',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                      width: 2,
                                      color: Colors
                                          .black54), // Set border width and color
                                ),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            ChangeNotifierProvider<UserVM>(
                              create: (BuildContext context) => userVM,
                              child: Consumer<UserVM>(
                                builder: (context, viewModel, _) {
                                  bool _isLoading =
                                      viewModel.user.status == Status.LOADING;
                                  return Column(
                                    children: [
                                      switchStatus(viewModel),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed:
                                            _isLoading ? null : onRegister,
                                        child: Text('REGISTRATE'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _isLoading
                                              ? Colors.grey
                                              : Colors.blue,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 30),
                            TextButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child:
                                  Text('¿Ya tienes una cuenta? Inicia sesión'),
                            ),
                          ],
                        ),
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  Widget switchStatus(viewModel) {
    switch (viewModel.user.status) {
      case Status.LOADING:
        print("Log :: LOADING");
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
          height: MediaQuery.of(context).size.height * 0.05,
        );
      case Status.ERROR:
        print("Log :: ERROR");
        try {
          var decodedJson = jsonDecode(viewModel.user.message!);
          var errorMessage = decodedJson["message"];

          return Container(
            width: double.infinity,
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
        } catch (e) {
          return Container(
            width: double.infinity,
            child: Text(
              "Estamos presentando errores... Vuelve a intentar más tarde",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }
      case Status.OFFLINE:
        print("Log :: OFFLINE");
        return Text(
          "Revisa tu conexión y vuelve a intentar",
          style: TextStyle(
            color: Colors.red,
          ),
        );
      case Status.COMPLETED:
        return Builder(
          builder: (context) {
            cache.flush();
            cache.write("login-username", _username.text);
            Future.delayed(Duration(milliseconds: 100)).then((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Login(
                          redirection: "signup",
                        )),
              );
            });
            return Container();
          },
        );
      case Status.NONE:
        return Container(
          width: double.infinity,
          child: Text(
            _validationError,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _validationError == "" ? Colors.white : Colors.red,
            ),
          ),
        );
      default:
        return Container();
    }
  }

  void onRegister() async {
    // Validation Step
    // 1. Check that all fields are filled
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _validationError = "";
      });
      return;
    }
    if (_career == "") {
      setState(() {
        _validationError = "Por favor, selecciona un departamento";
      });
      return;
    }
    if (_selectedDate == null) {
      setState(() {
        _validationError = "Por favor, selecciona una fecha de nacimiento";
      });
      return;
    }
    // 5. Send to backend and wait for response, if response is error, show error message
    setState(() {
      _validationError = "";
    });
    await userVM.registerUser(
      _name.text,
      _username.text,
      _email.text,
      _password.text,
      _career,
      _selectedDate!,
    );
  }
}
