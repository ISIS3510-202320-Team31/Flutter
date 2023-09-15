// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive_app/Login.dart';
import 'Profile.dart';
import 'Find.dart';
import 'Calendar.dart';
import 'Create.dart';

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

    /* Colors.tealAccent,*/
    secondaryHeaderColor: Color.fromARGB(223, 255, 195, 113) /* Colors.teal*/
    

    // fontFamily:
  );



int sel = 0;
double? width;
double? height;
final bodies = [HomeScreen(), Find(), Create(), Calendar(), Profile()];

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
          Icons.search,
          color: appTheme.focusColor,
        ),
        icon: Icon(
          Icons.search,
          color: appTheme.unselectedWidgetColor,
        ),
        label: "Encontrar"));
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
    // Navigation.selindex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),
      

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
  var isFlightselected = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            height: height! * .99 < 450 ? height! * .99 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              appTheme.primaryColor,
              appTheme.secondaryHeaderColor
            ])),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      
                      Spacer(),
                      
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 16,
                ),
                Text(
                  'HIVE',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                Container(
                  width: 400, // LONGITUD DE LA BARRA DE BUSQUEDA
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
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
                              horizontal: 32, vertical: 13),
                          suffixIcon: Material(
                            child: InkWell(
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onTap: () {}
                              
                            ),
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          )),
                    ),
                  ),
                ),     
              ],
            ),
          ),
        )
      ],
    );
  }
}


var viewallstyle =
    TextStyle(fontSize: 14, color: appTheme.primaryColor //Colors.teal
        );
var homeDown = Column(
  children: <Widget>[
    
  ],
);
