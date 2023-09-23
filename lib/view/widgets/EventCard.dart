import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa la biblioteca intl
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/view/widgets/EventDetail.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    // Formatea la fecha utilizando DateFormat
    String formattedDate = event.date != null
        ? DateFormat('dd/MM/yyyy').format(event.date!)
        : 'Sin fecha';

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetail(event: event),
          ),
        );
      },
      child:Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${event.creator ?? "Sin creador"}",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    event.name ?? "Sin nombre",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    event.description ?? "Sin descripcion",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Fecha: $formattedDate", // Utiliza la fecha formateada
                    style: TextStyle(fontSize: 14.0),
                  )                  
                ],
              ),
            ),
            Icon(
              Icons.event,
              size: 48.0,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    ) 
    );
  }
}




