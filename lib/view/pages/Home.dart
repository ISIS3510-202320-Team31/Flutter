import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Profile.dart';
import 'package:hive_app/view/pages/Calendar.dart';
import 'package:hive_app/view/pages/Create.dart';
import 'package:hive_app/view/pages/Feed.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
State<Home> createState() =>_NavState();
}

class _NavState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Feed(),
    Create(),
    Calendar(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                color: appTheme.focusColor,
              ),
              icon: Icon(
                Icons.home,
                color: appTheme.unselectedWidgetColor,
              ),
              label: "Inicio"),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.add_circle,
                color: appTheme.focusColor,
              ),
              icon: Icon(
                Icons.add_circle,
                color: appTheme.unselectedWidgetColor,
              ),
              label: "Crear"),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.calendar_month,
                color: appTheme.focusColor,
              ),
              icon: Icon(
                Icons.calendar_month,
                color: appTheme.unselectedWidgetColor,
              ),
              label: "Calendario"),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.account_circle,
                color: appTheme.focusColor,
              ),
              icon: Icon(
                Icons.account_circle,
                color: appTheme.unselectedWidgetColor,
              ),
              label: "Perfil")],
          unselectedItemColor: Colors.black,
          selectedItemColor: appTheme.focusColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: _selectedIndex,
          elevation: 1.5,
          onTap: (int index) {
            if (index != _selectedIndex)
              setState(() {
                _selectedIndex = index;
              });
          },
        )
    );
  }
}