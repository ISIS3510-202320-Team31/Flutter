import 'package:flutter/material.dart';

class ViewsHeader extends StatelessWidget {
  final String titleText; // Parámetro para el texto del título
  ViewsHeader({required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20), // Aplica un margen hacia abajo de 10 píxeles
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleText, // Usa el texto proporcionado como título
            style: TextStyle(
              fontSize: 40,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Image.asset(
            'assets/images/HIVE_LOGO_small.png',
            width: 65,
            height: 65,
          ),
        ],
      ),
    );
  }
}


