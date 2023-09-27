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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: appTheme.cardColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0), // Ajusta el radio para bordes redondeados del Dialog
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Establece el tamaño mínimo basado en el contenido
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
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
          SizedBox(height: 30.0),
            Center(
              child: Icon(
                Icons.event,
                size: 100.0,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos horizontalmente
              children: [
                Expanded( // Distribuye el espacio disponible uniformemente entre las columnas
                  child: Column(
                    children: [
                      Text('${event.creator ?? 'Sin creador'}'),
                      SizedBox(height: 10.0),
                      Text('$formattedDate')
                    ],
                  ),
                ),
                Expanded( // Distribuye el espacio disponible uniformemente entre las columnas
                  child: Column(
                    children: [
                      Text('Categoria: ${event.category ?? 'Sin categoria'}'),
                      SizedBox(height: 10.0),
                      Text('${event.duration ?? 'Sin duración'} min')
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(20.0),
              width: double.maxFinite,
              color: Color.fromARGB(150, 255, 241, 89),
              child: Text('${event.description ?? 'Sin descripción'}',style:TextStyle(fontSize: 13)),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child:Column(
                    children: [
                      Center(
                      child: Text('Lugar: ${event.place ?? 'Sin lugar'}'),
                      ),
                      SizedBox(height: 5.0),
                      Center(
                        child: Text('Participantes: ${event.numParticipants ?? 0}'),
                      ),
                      SizedBox(height: 5.0),
                      Center(
                        child: Text('Enlaces: ${event.links ?? 'Sin enlaces'}'),
                      ),
                      SizedBox(height: 5.0),
                      Center(
                        child: Text('Estado: ${event.state ?? false ? 'Activo' : 'Inactivo'}'),
                      ),
                    ],
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0,bottom: 30.0),
                  child:IconButton(
                  icon: Icon(
                    Icons.qr_code,
                    color: Colors.black,
                    size: 60.0,
                  ),
                  onPressed: () {
                    // Acción que deseas ejecutar cuando se presiona el botón izquierdo
                  },
                  color: appTheme.hintColor
                )
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los botones horizontalmente
              children: [
                SizedBox(width: 30.0),
                Expanded( // Distribuye el espacio disponible uniformemente entre los botones
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: appTheme.hintColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Cierra el diálogo y vuelve a la vista anterior
                    },
                    child: Text('Cancelar', style: TextStyle(color:appTheme.cardColor),),
                  ),
                ),
                SizedBox(width: 30.0),
                Expanded( // Distribuye el espacio disponible uniformemente entre los botones
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: appTheme.hintColor,
                    ),
                    onPressed: () {
                    },
                    child: Text('Unirse', style: TextStyle(color:appTheme.cardColor),),
                  ),
                ),
                SizedBox(width: 30.0),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        )
      )
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
