import 'package:flutter/material.dart';
import 'main.dart';

//Unused
// ignore: must_be_immutable
class Navigation extends StatelessWidget {
  static int? selindex;
  static List<BottomNavigationBarItem> items = [];

  Navigation() {
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Inicio"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.add_circle,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.add_circle,
          color: Colors.black,
        ),
        label: "Crear"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.calendar_month,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.calendar_month,
          color: Colors.black,
        ),
        label: "Calendario"));
    items.add(BottomNavigationBarItem(
        //backgroundColor: Colors.blue,
        activeIcon: Icon(
          Icons.account_circle,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        label: "Perfil"));
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
      unselectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
      currentIndex: selindex!,
      elevation: 1.5,
    );
  }

  int index = 0;
}

class NavigationTest extends StatefulWidget {
  @override
  _NavigationTest createState() => _NavigationTest();
}

class _NavigationTest extends State<NavigationTest> {
  final List<BottomNavigationBarItem> items = [];
  int index = -1;
  Widget navigation() {
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Inicio"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.search,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        label: "Encontrar"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.add_circle,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.add_circle,
          color: Colors.black,
        ),
        label: "Crear"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.calendar_month,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.calendar_month,
          color: Colors.black,
        ),
        label: "Calendario"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.account_circle,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        label: "Perfil"));

    return BottomNavigationBar(
      items: items,
      type: BottomNavigationBarType.fixed,
      currentIndex: -1 + 1,
      elevation: 1.5,
      onTap: (sel) {},
      selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
      unselectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigation();
  }
}
