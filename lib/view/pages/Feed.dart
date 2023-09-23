import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';


class Feed extends StatefulWidget {
  static const String id = "feed_screen";

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final EventVM eventVM = EventVM();

  @override
  void initState() {
    eventVM.fetchEventData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
        ),
      ),
      child: Column(
        children: <Widget>[
          Search(),
          Expanded(
            child: EventList(), // Aquí incluye el EventList
          ),
        ],
      ),
    );
  }
}

class Search extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
    Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
    );
  }
}