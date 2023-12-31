import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/pages/Profile.dart';
import 'package:hive_app/view/pages/Calendar.dart';
import 'package:hive_app/view/pages/EventCreate.dart';
import 'package:hive_app/view/pages/Feed.dart';
import 'package:hive_app/view/pages/TopCreators.dart';

class Home extends StatefulWidget {
  final String userId;
  final int? initialIndex;
  const Home({super.key, required this.userId, this.initialIndex});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex;

  List<Widget> _navOptions = [];

  @override
  void initState() {
    _selectedIndex = widget.initialIndex ?? 0;
    _navOptions = [
      Feed(userId: widget.userId),
      EventCreate(userId: widget.userId),
      Calendar(userId: widget.userId),
      TopCreators(),
      Profile(userId: widget.userId)
    ];
    super.initState();
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
                  Icons.verified_outlined,
                  color: appTheme.focusColor,
                ),
                icon: Icon(
                  Icons.verified_outlined,
                  color: appTheme.unselectedWidgetColor,
                ),
                label: "Top Creadores"),
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
