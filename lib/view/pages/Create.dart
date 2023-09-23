import 'package:flutter/material.dart';
import 'package:hive_app/view/pages/ViewsHeader.dart';
import 'package:hive_app/utils/ColorPalette.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  DateTime selectedDate = DateTime.now();
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  String selectedCategory = 'Conferencia'; // Valor predeterminado para el primer DropdownButton
  String selectedParticipants = 'Estudiante'; // Valor predeterminado para el segundo DropdownButton

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    super.dispose();
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
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  ViewsHeader(
                    titleText: "Crear evento",
                  ),
                  TextFormField(
                    controller: textController1,
                    decoration: InputDecoration(labelText: 'Titulo del evento:'),
                  ),
                  TextFormField(
                    controller: textController2,
                    decoration: InputDecoration(labelText: 'Lugar del evento:'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (dateTime != null) {
                        setState(() {
                          selectedDate = dateTime;
                        });
                      }
                    },
                    child: Text('Seleccionar fecha del evento:'),
                  ),
                  DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: <String>['Conferencia', 'Charla', 'Grupo']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Seleccionar categoria: $value'),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedParticipants,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedParticipants = newValue!;
                      });
                    },
                    items: <String>['Estudiante', 'Personal', 'Profesor']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Seleccionar participantes: $value'),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agrega links de interes:'),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para manejar el botón aquí
                    },
                    child: Text('Guardar'),
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





