import 'package:flutter/material.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/view/widgets/EventCard.dart';

class EventList extends StatelessWidget {
  final List<Event> eventList;

  EventList({required this.eventList});

  @override
  Widget build(BuildContext context) {
    return _buildEventListView(context, eventList);
  }

  Widget _buildEventListView(BuildContext context, List<Event> events) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: 0,
        left: MediaQuery.of(context).size.width * 0.02,
        right: MediaQuery.of(context).size.width * 0.02,
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventCard(
          event: event,
        );
      },
    );
  }
}
