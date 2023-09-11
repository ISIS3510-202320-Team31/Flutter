import 'package:flutter/material.dart';
import 'package:hive_app/main.dart';

class Create extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "VISTA DEL CREATE",
            style: TextStyle(
              fontSize: 30, // Tamaño de fuente deseado
              fontFamily: "Arial", // Fuente deseada
              fontWeight: FontWeight.bold, // Peso de la fuente (opcional)
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
    );
  }
}


