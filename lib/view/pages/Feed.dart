import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/view/widgets/SearchBar.dart';


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

