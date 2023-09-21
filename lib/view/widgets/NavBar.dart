import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Profile.dart';
import 'package:hive_app/view/pages/Calendar.dart';
import 'package:hive_app/view/pages/Create.dart';
import 'package:hive_app/view/pages/Feed.dart';

int sel = 0;

final bodies = [Feed(), Create(), Calendar(), Profile()];

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
    return BottomNavigationBar(
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
        );
  }
}

