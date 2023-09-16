import 'package:flutter/material.dart';
import 'package:hive_app/main.dart';

class Calendar extends StatelessWidget {
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
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "VISTA DEL CALENDAR",
                style: TextStyle(
                  fontSize: 30, // Tamaño de fuente deseado
                  fontFamily: "Jost", // Fuente deseada
                  fontWeight: FontWeight.bold, // Peso de la fuente en negrita
                  color: Colors.black, // Color del texto (opcional)
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 100,
                child: Image.asset('assets/images/HIVE_LOGO_small.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



