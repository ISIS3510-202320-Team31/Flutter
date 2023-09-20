import 'package:flutter/material.dart';
import 'package:hive_app/main.dart';

class Profile extends StatelessWidget {
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
            padding: EdgeInsets.only(top: 75), // 75 Pixeles de distancia hasta arriba
            child: Container(
              width: double.infinity, // Establece el ancho del contenedor al ancho máximo posible
              padding: EdgeInsets.symmetric(horizontal: 30), // Agrega 30 píxeles de espacio en cada lado
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Perfil",
                    style: TextStyle(
                      fontSize: 40, // Tamaño de fuente deseado
                      fontFamily: "Montserrat", // Fuente deseada
                      fontWeight: FontWeight.bold, // Peso de la fuente en negrita
                      color: Colors.black, // Color del texto (opcional)
                    ),
                  ),
                  Image.asset(
                  'assets/images/HIVE_LOGO_small.png',
                  width: 65, // Establece el ancho de la imagen en 70 píxeles
                  height: 65, // Establece la altura de la imagen en 70 píxeles
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
