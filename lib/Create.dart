import 'package:flutter/material.dart';
import 'package:hive_app/main.dart';

class Create extends StatelessWidget {
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
                "VISTA DEL CREATE",
                style: TextStyle(
                  fontSize: 30, // Tamaño de fuente deseado
                  fontFamily: "Arial", // Fuente deseada
                  fontWeight: FontWeight.bold, // Peso de la fuente 
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




