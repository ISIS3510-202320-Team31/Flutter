import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_app/models/event.model.dart';

class EventDetail extends StatelessWidget {
  final Event event;

  EventDetail({required this.event});

  @override
  Widget build(BuildContext context) {
    String formattedDate = event.date != null
        ? DateFormat('dd/MM/yyyy').format(event.date!)
        : 'Sin fecha';

    return Container();

  }
  // Función para mostrar el cuadro de diálogo de detalles del evento
  static void showEventDetail(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EventDetail(event: event);
      },
    );
  }
}
