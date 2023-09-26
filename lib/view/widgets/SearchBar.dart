import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';


class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Row(
        children: [
          // Icono de filtro a la izquierda
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: appTheme.focusColor,
            ),
            onPressed: () {
              // Acción que deseas ejecutar cuando se presiona el botón izquierdo
            },
          ),
          // Barra de búsqueda que ocupa el espacio disponible
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                cursorColor: appTheme.primaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Buscar...",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  suffixIcon: Material(
                    child: InkWell(
                      child: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 33, 150, 243),
                      ),
                      onTap: () {
                        // Acción que deseas ejecutar cuando se presiona el botón de búsqueda
                      },
                    ),
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
            ),
          ),
          // Icono a la derecha
          IconButton(
            icon: Icon(
              Icons.center_focus_weak,
              color: appTheme.focusColor,
            ),
            onPressed: () {
              // Acción que deseas ejecutar cuando se presiona el botón derecho
            },
          ),
        ],
      ),
    );
  }
}