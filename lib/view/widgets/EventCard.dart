import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/view/widgets/EventDetail.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class EventCard extends StatefulWidget {
  final String userId;
  final Event event;

  EventCard({required this.userId, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  void initState() {
    analytics.setAnalyticsCollectionEnabled(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Formatea la fecha utilizando DateFormat
    String formattedDate = widget.event.date != null
        ? DateFormat('dd/MM/yyyy').format(widget.event.date!)
        : 'Sin fecha';

    return GestureDetector(
        onTap: () async {
          print("tapped event ${widget.event.id}");
          await analytics.logEvent(
            name: 'select_content',
            parameters: <String, String>{
              'id': "item_${widget.event.id!}",
              'name': "${widget.event.id!}:${widget.event.name!}",
              'content_type': 'CardView Item (${widget.event.name})',
            },
          );
          showDialog(
              context: context,
              builder: (BuildContext context) => EventDetail(
                  userId: widget.userId, eventId: widget.event.id!));
        },
        child: Card(
          margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10, top: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.event.creator ?? "Sin creador"}",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Text(
                        widget.event.name ?? "Sin nombre",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        widget.event.description ?? "Sin descripcion",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Fecha: $formattedDate", // Utiliza la fecha formateada
                        style: TextStyle(fontSize: 14.0),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.event,
                  size: 80.0,
                  color: Colors.blue,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03)
              ],
            ),
          ),
        ));
  }
}
