import 'package:flutter/material.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/view/widgets/EventCard.dart';
import 'package:hive_app/view_model/event.vm.dart';

class EventList extends StatefulWidget {
  final List<Event> eventList;

  EventList({required this.eventList});

  _EventList createState() => _EventList(eventList: eventList);
}

class _EventList extends State<EventList> {
  final eventList;
  EventVM eventVM = EventVM();
  _EventList({required this.eventList});

  Future<void> _handleRefresh() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
    onRefresh:_handleRefresh,
    child: ListView.builder(
      padding: EdgeInsets.only(
        top: 0,
        left: MediaQuery.of(context).size.width * 0.02,
        right: MediaQuery.of(context).size.width * 0.02,
      ),
      itemCount: eventList.length,
      itemBuilder: (context, index) {
        final event = eventList[index];
        return EventCard(
          event: event,
        );
      },
    ));
  }
}
