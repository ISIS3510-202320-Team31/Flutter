import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/QRscanner.dart';

class Search extends StatefulWidget {
  final String userId;

  const Search({required this.userId});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // Lista de opciones para el menú desplegable
  final List<String> options = ['Opción 1', 'Opción 2', 'Opción 3'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
                  builder: (context) => QRscanner(userId: widget.userId)),
            );
          },
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.24),
        Text('HIVE!',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
        SizedBox(width: MediaQuery.of(context).size.width * 0.14),
        // Menú desplegable
        PopupMenuButton<String>(
          offset: Offset(0, 35), // Ajusta el valor según sea necesario
          onSelected: (String value) {
            print(value); // Imprimir la opción seleccionada
          },
          itemBuilder: (BuildContext context) {
            return options.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          child: Row(
            children: [
              Text(
                'Filtrar',
                style: TextStyle(
                  color: appTheme.hintColor,
                  //fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: appTheme.hintColor,
                size: 30.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
