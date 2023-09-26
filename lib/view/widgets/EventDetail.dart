import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
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

    return Dialog(
      backgroundColor: appTheme.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Establece el tamaño mínimo basado en el contenido
        children: <Widget>[
          Container(
            color: Color.fromARGB(150, 255, 241, 89),
            child: Center(
              child: Text(
                event.name ?? 'Sin nombre',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
         SizedBox(height: 10.0),
          Center(
            child: Icon(
              Icons.event,
              size: 100.0,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos horizontalmente
            children: [
              Expanded( // Distribuye el espacio disponible uniformemente entre las columnas
                child: Column(
                  children: [
                    Text('${event.creator ?? 'Sin creador'}'),
                    Text('$formattedDate')
                  ],
                ),
              ),
              Expanded( // Distribuye el espacio disponible uniformemente entre las columnas
                child: Column(
                  children: [
                    Text('Categoria: ${event.category ?? 'Sin categoria'}'),
                    Text('${event.duration ?? 'Sin duración'} min')
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            width: double.maxFinite,
            color: Color.fromARGB(150, 255, 241, 89),
            child: Text('${event.description ?? 'Sin descripción'}'),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text('Lugar: ${event.place ?? 'Sin lugar'}'),
          ),
          Center(
            child: Text('Participantes: ${event.numParticipants ?? 0}'),
          ),
          Center(
            child: Text('Enlaces: ${event.links ?? 'Sin enlaces'}'),
          ),
          Center(
            child: Text('Estado: ${event.state ?? false ? 'Activo' : 'Inactivo'}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los botones horizontalmente
            children: [
              Expanded( // Distribuye el espacio disponible uniformemente entre los botones
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Cierra el diálogo y vuelve a la vista anterior
                  },
                  child: Text('Cancelar'),
                ),
              ),
              Expanded( // Distribuye el espacio disponible uniformemente entre los botones
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {},
                  child: Text('Unirse'),
                ),
              ),
            ],
          )
        ],
      ),
    );
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
