import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Profile.dart';
import 'package:hive_app/view/pages/Calendar.dart';
import 'package:hive_app/view/pages/EventCreate.dart';
import 'package:hive_app/view/pages/Feed.dart';

class Home extends StatefulWidget {
  final String? userId;
  const Home({super.key, this.userId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _navOptions = [];

  @override
  void initState() {
    _navOptions = [
      Feed(userId: widget.userId),
      EventCreate(),
      Calendar(),
      Profile()
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _navOptions.elementAt(_selectedIndex)),
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
                label: "Perfil")
          ],
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
        ));
  }
}
