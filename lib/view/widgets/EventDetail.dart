import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:intl/intl.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventDetail extends StatelessWidget {
  final Event event;

  EventDetail({required this.event});

  Future<void> _abrirEnlace(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir el enlace: $url';
    }
  }
  
  void _showQRCodeDialog(BuildContext context, String qrData) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child:
        Expanded(
          child:QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.width *0.8,
        ),
        )
        
      );
    },
  );
}

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
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                SizedBox(width: 20.0),
                Text('${event.state != null && event.state! ? 'Activo' : 'Cancelado'}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),                
                SizedBox(width: 15.0),
                Icon(
                Icons.location_on,
                size: 25.0,
                color: appTheme.focusColor,
                ),
                Text('${event.place ?? ''}')

              ],
            ),
          SizedBox(height: 20.0),
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
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: appTheme.unselectedWidgetColor ,
                          border: Border.all(
                            color: appTheme.unselectedWidgetColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text('${event.category ?? 'Sin categoria'}',style: TextStyle(color: appTheme.cardColor )),
                      ),
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
            SizedBox(height: 5.0),
            Center(
            child: Container(
                        padding: EdgeInsets.only(bottom: 5.0,top: 5.0,left: 30.0,right: 30.0),
                        decoration: BoxDecoration(
                          color: appTheme.unselectedWidgetColor ,
                          border: Border.all(
                            color: appTheme.unselectedWidgetColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text('Links de interes',style: TextStyle(color: appTheme.cardColor )),
                      )
            ),
            Center(
              child: Container(
                width: 100.0, // Establece el ancho deseado
                height: 100.0, // Establece la altura deseada
                child: InkWell(
                  onTap: () {
                    _showQRCodeDialog(context, event.id.toString());
                  },
                  child: Icon(
                    Icons.qr_code,
                    color: Colors.black,
                    size: 100.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            if (event.links != null && event.links!.isNotEmpty)
              Container(
              constraints: BoxConstraints(
                maxHeight: 100.0, // Establece la altura máxima según tus necesidades
              ),
              child: ListView.builder(
                itemCount: event.links!.length,
                shrinkWrap: true, // Permite que el ListView se ajuste automáticamente
                physics: ClampingScrollPhysics(), // Desactiva el desplazamiento del ListView
                itemBuilder: (context, index) {
                  final link = event.links![index];
                  return ListTile(
                    leading: Icon(Icons.link),
                    title: Text(link),
                    onTap: () {
                      _abrirEnlace(link);
                    },
                  );
                },
              ),
            ),
            if (event.numParticipants != null && event.participants!=null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    Icons.group,
                    color: Colors.black,
                    size: 20.0,
                  ),
                SizedBox(width: 10.0),
                Text(
                  '${event.participants?.length}/${event.numParticipants} asistentes',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ), 
            SizedBox(height: 10.0),
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
