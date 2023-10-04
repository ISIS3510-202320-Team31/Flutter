import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_app/view/pages/ViewsHeader.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/data/remote/response/Status.dart';

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

final Map<String, String> _categories = {
  "Académico": "ACADEMIC",
  "Cultural": "CULTURAL",
  "Deportivo": "SPORTS",
  "Entretenimiento": "ENTERTAINMENT",
  "Otro": "OTHER",
};

class EventCreate extends StatefulWidget {
  final String userId;
  const EventCreate({required this.userId});

  @override
  _EventCreateState createState() => _EventCreateState();
}

class _EventCreateState extends State<EventCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _place = TextEditingController();
  TextEditingController _duration = TextEditingController();
  TextEditingController _participants = TextEditingController();
  DateTime? _selectedDate;
  String _category = "";
  TextEditingController _description = TextEditingController();
  TextEditingController _links = TextEditingController();
  TextEditingController _tags = TextEditingController();
  String _validationError = "";

  final EventVM eventVM = EventVM();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 75),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ViewsHeader(
                      titleText: "Crear evento",
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _title,
                              decoration: InputDecoration(
                                  labelText: 'Título del evento'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa el título del evento';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _place,
                              decoration: InputDecoration(
                                  labelText: 'Lugar del evento'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa el lugar del evento';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _duration,
                              decoration: InputDecoration(
                                  labelText:
                                      'Duración del evento (en minutos)'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa la duración del evento';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _participants,
                              decoration: InputDecoration(
                                  labelText: 'Cantidad de participantes'),
                              keyboardType: TextInputType.number,
                              // no validator, optional field
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Fecha del evento',
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
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Tipo de evento',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              items: _categories.keys
                                  .map((String key) => DropdownMenuItem(
                                        value: key,
                                        child: Text(key),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _category = _categories[value]!;
                                });
                              },
                            ),
                            TextFormField(
                              controller: _description,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  labelText: 'Descripción del evento'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingresa la descripción del evento';
                                }
                                if (value.length > 500) {
                                  return 'La descripción no puede tener más de 500 caracteres';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                                controller: _links,
                                decoration: InputDecoration(
                                    labelText:
                                        'Links de interés (separados por comas)'),
                                validator: (value) {
                                  final links = value!.split(',');
                                  if (links.length > 5) {
                                    return 'No puedes agregar más de 5 links';
                                  }
                                  return null;
                                }),
                            TextFormField(
                              controller: _tags,
                              decoration: InputDecoration(
                                  labelText: 'Tags (separados por comas)'),
                              validator: (value) {
                                final tags = value!.split(',');
                                if (tags.length > 5) {
                                  return 'No puedes agregar más de 5 tags';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            ChangeNotifierProvider<EventVM>(
                              create: (BuildContext context) => eventVM,
                              child: Consumer<EventVM>(
                                builder: (context, viewModel, _) {
                                  switch (viewModel.event.status) {
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
                                          jsonDecode(viewModel.event.message!)[
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
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home(
                                                      userId: widget.userId)),
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
                                if (_selectedDate == null) {
                                  setState(() {
                                    _validationError =
                                        "Por favor, selecciona una fecha";
                                  });
                                  return;
                                }
                                if (_category == "") {
                                  setState(() {
                                    _validationError =
                                        "Por favor, selecciona una categoría";
                                  });
                                  return;
                                }
                                // 2. Check that the date is not in the past
                                if (_selectedDate!.isBefore(DateTime.now())) {
                                  setState(() {
                                    _validationError =
                                        "Por favor, selecciona una fecha futura";
                                  });
                                  return;
                                }
                                // 3. Send to backend and wait for response, if response is error, show error message
                                List<String> tags = _tags.text.split(',');
                                List<String> links = _links.text.split(',');
                                await eventVM.createEvent(
                                  _title.text,
                                  _place.text,
                                  // duration as int: _duration.text,
                                  int.parse(_duration.text),
                                  _participants.text == ""
                                      ? 0
                                      : int.parse(_participants.text),
                                  _selectedDate!,
                                  _category,
                                  _description.text,
                                  tags,
                                  links,
                                  widget.userId,
                                );
                              },
                              child: Text('CREAR EVENTO'),
                            ),
                          ],
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
}
