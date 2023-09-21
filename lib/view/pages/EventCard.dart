import 'package:flutter/material.dart';
import 'package:hive_app/models/event.model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(event.name ?? "Sin nombre"),
        // You can add more info here
      ),
    );
  }
}
