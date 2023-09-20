import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[HomeTop(), homeDown, homeDown],
        ),
      ),
    );
  }
}

class HomeTop extends StatefulWidget {
  @override
  _HomeTop createState() => _HomeTop();
}

class _HomeTop extends State<HomeTop> {
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
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 75), // 75 Pixeles de distancia hasta arriba
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 30),
                        // Centra la barra de búsqueda
                        Container(
                          width: 310, // LONGITUD DE LA BARRA DE BUSQUEDA
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              cursorColor: appTheme.primaryColor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 13),
                                suffixIcon: Material(
                                  child: InkWell(
                                    child: Icon(
                                      Icons.search,
                                      color: Color.fromARGB(255, 33, 150, 243),
                                    ),
                                    onTap: () {},
                                  ),
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Agregar el segundo contenedor con la misma información
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    height: 700, // LO DEFINO PARA SABER CUANTOS EVENTOS PUEDEN CABER ACA
                    padding: EdgeInsets.symmetric(horizontal: 20).add(
                      EdgeInsets.only(top: 30), // 75 Pixele// 75 Pixeles de distancia hasta arriba
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Eventos",
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



var homeDown = Column(
  children: <Widget>[
    
  ],
);
