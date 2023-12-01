import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/QRscanner.dart';

class Search extends StatefulWidget {
  final String userId;

  const Search({required this.userId});

  @override
  _SearchState createState() => _SearchState(this);

  getDropdownValue() {} // Pasa una instancia de Search
}

class _SearchState extends State<Search> {
  final Search _search;
  _SearchState(this._search);
  String dropdownValue = "A"; // Valor seleccionado inicialmente

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        // Icono de filtro a la izquierda
        IconButton(
          icon: Icon(
            Icons.center_focus_weak,
            color: appTheme.focusColor,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRscanner(userId: widget.userId),
              ),
            );
          },
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.25),
        Text(
          'HIVE!',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        DropdownButton(
          value: dropdownValue,
          onChanged: (value) {
            setState(() {
              dropdownValue = value.toString();
            });
            // Aquí puedes realizar acciones adicionales al seleccionar un nuevo valor
          },
          iconEnabledColor: Colors.blueAccent,
          iconSize: 40.0,
          style: TextStyle(color: Colors.blue, fontSize: 20.0),
          items: const [
            DropdownMenuItem(child: Text("All"), value: "A"),
            DropdownMenuItem(child: Text("Academic"), value: "E"),
            DropdownMenuItem(child: Text("Cultural"), value: "I"),
            DropdownMenuItem(child: Text("Sports"), value: "O"),
            DropdownMenuItem(child: Text("Entertainment"), value: "U"),
          ],
        )
      ],
    );
  }

  String getDropdownValue() {
    return dropdownValue;
  }
}