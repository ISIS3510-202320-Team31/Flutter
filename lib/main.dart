
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_app/view/pages/Login.dart';
import 'view/pages/Profile.dart';
import 'view/pages/Calendar.dart';
import 'view/pages/Create.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BottomNav(),
    theme: appTheme,
    title: "HIVE",
    initialRoute: '/Login',
    routes: {'/Login': (BuildContext context ) => Login() },
    
  ));
}

ThemeData appTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 255, 241, 89),
    focusColor: Color.fromARGB(255, 37, 34, 31),
    cardColor:Color.fromARGB(255, 248, 248, 248),
    unselectedWidgetColor:Color.fromARGB(255,162, 174, 187),
    hintColor:Color.fromARGB(255, 33, 150, 243),
    secondaryHeaderColor: Color.fromARGB(223, 255, 195, 113) /* Orage color just for background*/
    
  );



int sel = 0;

final bodies = [HomeScreen(), Create(), Calendar(), Profile()];

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: appTheme.focusColor,
        ),
        icon: Icon(
          Icons.home,
          color: appTheme.unselectedWidgetColor,
        ),
        label: "Inicio"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.add_circle,
          color: appTheme.focusColor,
        ),
        icon: Icon(
          Icons.add_circle,
          color: appTheme.unselectedWidgetColor,
        ),
        label: "Crear"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.calendar_month,
          color: appTheme.focusColor,
        ),
        icon: Icon(
          Icons.calendar_month,
          color: appTheme.unselectedWidgetColor,
        ),
        label: "Calendario"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.account_circle,
          color: appTheme.focusColor,
        ),
        icon: Icon(
          Icons.account_circle,
          color: appTheme.unselectedWidgetColor,
        ),
        label: "Perfil"));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodies.elementAt(sel),
        bottomNavigationBar: BottomNavigationBar(
          items: createItems(),
          unselectedItemColor: Colors.black,
          selectedItemColor: appTheme.focusColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: sel,
          elevation: 1.5,
          onTap: (int index) {
            if (index != sel)
              setState(() {
                sel = index;
              });
          },
        ));
  }
}

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
