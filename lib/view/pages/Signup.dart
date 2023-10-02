import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/view/pages/Login.dart';
import 'package:hive_app/view_model/user.vm.dart';

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
    }
  }

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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _name,
                              decoration: InputDecoration(labelText: 'Nombre'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu nombre';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _username,
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
                              controller: _email,
                              decoration: InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu correo';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _password,
                              decoration:
                                  InputDecoration(labelText: 'Contraseña'),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu contraseña';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _confirmpassword,
                              decoration: InputDecoration(
                                  labelText: 'Confirmar contraseña'),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa tu contraseña de nuevo';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Carrera',
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
                              onChanged: (value) {
                                setState(() {
                                  _career = _dropdownValues[value]!;
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
                            Container(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                _validationError,
                                style: TextStyle(
                                  color: _validationError == ""
                                      ? Colors.white
                                      : Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                // Validation Step
                                // 1. Check that all fields are filled
                                /*if (!_formKey.currentState!.validate()) {
                                  setState(() {
                                    _validationError = "";
                                  });
                                  return;
                                }
                                if (_career == "") {
                                  setState(() {
                                    _validationError =
                                        "Por favor, selecciona una carrera";
                                  });
                                  return;
                                }
                                if (_selectedDate == null) {
                                  setState(() {
                                    _validationError =
                                        "Por favor, selecciona una fecha de nacimiento";
                                  });
                                  return;
                                }
                                // 2. Check that the email is valid
                                RegExp emailRegex = RegExp(
                                    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                if (!emailRegex.hasMatch(_email.text)) {
                                  setState(() {
                                    _validationError =
                                        "Por favor, ingresa un correo válido";
                                  });
                                  return;
                                }
                                // 3. Check that the password is valid
                                RegExp passwordRegex = RegExp(
                                    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
                                if (!passwordRegex.hasMatch(_password.text)) {
                                  setState(() {
                                    _validationError =
                                        "La contraseña debe tener al menos 8 caracteres, una mayúscula y un número";
                                  });
                                  return;
                                }
                                // 4. Check that the password and confirm password fields match
                                if (_password.text != _confirmpassword.text) {
                                  setState(() {
                                    _validationError =
                                        "Las contraseñas no coinciden";
                                  });
                                  return;
                                }*/
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
                                // 6. If answer is success, go to login page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              },
                              child: Text('REGISTRATE'),
                            ),
                            SizedBox(height: 10),
                            TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
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
}
