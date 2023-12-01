import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:intl/intl.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view_model/user.vm.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/view/widgets/OfflineWidget.dart';
import 'package:hive_app/view/pages/Home.dart';

class EventDetail extends StatefulWidget {
  final String userId;
  final String eventId;
  EventDetail({required this.userId, required this.eventId});

  @override
  _EventDetailState createState() => _EventDetailState(eventId);
}

class _EventDetailState extends State<EventDetail> {
  final eventId;
  final EventVM eventVM = EventVM();
  final UserVM userVM = UserVM();
  bool isUserParticipant = false;
  bool flagDescription = true;

  _EventDetailState(this.eventId);

  @override
  void initState() {
    eventVM.fetchEventById(widget.eventId);
    super.initState();
  }

  Future<void> _abrirEnlace(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el enlace: $url';
    }
  }

  _showQRCodeDialog(BuildContext context, String qrData) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
          child: QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: MediaQuery.of(context).size.width * 0.8,
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: appTheme.cardColor,
        child: ChangeNotifierProvider<EventVM>(
          create: (BuildContext context) => eventVM,
          child: Consumer<EventVM>(
            builder: (context, viewModel, _) {
              switch (viewModel.event.status) {
                case Status.LOADING:
                  print("Log :: LOADING");
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                    height: MediaQuery.of(context).size.height * 0.7,
                  );
                case Status.ERROR:
                  print("Log :: ERROR");
                  return Container(
                    child: Center(
                      child: Text(
                          "Estamos presentando errores... Intenta refrescar"),
                    ),
                  );
                case Status.OFFLINE:
                  print("Log :: OFFLINE");
                  return OfflineWidget();
                case Status.COMPLETED:
                  print("Log :: COMPLETED");
                  final event = viewModel.event.data!;

                  int isUserParticipant = 0;

                  if (event.creatorId == widget.userId) {
                    isUserParticipant = 3;
                  } else if (event.participants!.contains(widget.userId)) {
                    isUserParticipant = 1;
                  } else {
                    if (event.numParticipants != null &&
                        event.participants != null) {
                      if (event.participants!.length >=
                          event.numParticipants!) {
                        isUserParticipant = 2;
                      } else {
                        isUserParticipant = 0;
                      }
                    } else {
                      isUserParticipant = 0;
                    }
                  }

                  return Container(
                    child: showEventDetail(
                        context, event, widget.userId, isUserParticipant),
                  );
                default:
                  return Container();
              }
            },
          ),
        ));
  }

  // Función para mostrar el cuadro de diálogo de detalles del evento
  showEventDetail(
      BuildContext context, Event event, String userId, int isUserParticipant) {
    String formattedDate = event.date != null
        ? DateFormat('dd/MM/yyyy').format(event.date!)
        : 'Sin fecha';

    String firstHalf;
    String secondHalf;

    final lengthForHalf = 65;
    if (event.description!.length > lengthForHalf) {
      firstHalf = event.description!.substring(0, lengthForHalf);
      secondHalf = event.description!.substring(lengthForHalf);
    } else {
      firstHalf = event.description!;
      secondHalf = "";
    }

    String texto;
    if (isUserParticipant == 3) {
      texto = "Editar";
    } else if (isUserParticipant == 2) {
      texto = "Evento lleno";
    } else {
      texto = isUserParticipant == 1 ? 'No asistiré' : 'Unirse';
    }

    Color color;
    if (isUserParticipant == 3) {
      color = Colors.green;
    } else if (isUserParticipant == 2) {
      color = Colors.grey;
    } else {
      color = isUserParticipant == 1 ? Colors.red : Colors.blue;
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(
            30.0), // Ajusta el radio para bordes redondeados del Dialog
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize
              .min, // Establece el tamaño mínimo basado en el contenido
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Color.fromARGB(150, 255, 241, 89),
              child: Align(
                child: Text(
                  event.name ?? 'Sin nombre',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center-align text horizontally
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* // Show or not the active/cancelled text ?
                SizedBox(width: 20.0),
                Text(
                    '${event.state != null && event.state! ? 'Activo' : 'Cancelado'}',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                SizedBox(width: 15.0),*/
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
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centra los elementos horizontalmente
              children: [
                Expanded(
                  // Distribuye el espacio disponible uniformemente entre las columnas
                  child: Column(
                    children: [
                      Text('${event.creator ?? 'Sin creador'}'),
                      SizedBox(height: 10.0),
                      Text('$formattedDate')
                    ],
                  ),
                ),
                Expanded(
                  // Distribuye el espacio disponible uniformemente entre las columnas
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: appTheme.unselectedWidgetColor,
                          border: Border.all(
                            color: appTheme.unselectedWidgetColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text('${event.category ?? 'Sin categoria'}',
                            style: TextStyle(color: appTheme.cardColor)),
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
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 80.0,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                        flagDescription
                            ? (firstHalf + (secondHalf.isEmpty ? "" : "..."))
                            : (firstHalf + secondHalf),
                        style: TextStyle(fontSize: 13)),
                    // show the inkwell if secondHalf != ""
                    secondHalf.isEmpty
                        ? Text("")
                        : InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  flagDescription ? "ver más" : "ver menos",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                flagDescription = !flagDescription;
                              });
                            },
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Center(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: 5.0, top: 5.0, left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                color: appTheme.unselectedWidgetColor,
                border: Border.all(
                  color: appTheme.unselectedWidgetColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text('Links de interes',
                  style: TextStyle(color: appTheme.cardColor)),
            )),
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
            if (event.links != null &&
                event.links!.isNotEmpty &&
                event.links != [])
              Container(
                constraints: BoxConstraints(
                  maxHeight:
                      60.0, // Establece la altura máxima según tus necesidades
                ),
                child: ListView.builder(
                  itemCount: event.links!.length,
                  shrinkWrap:
                      true, // Permite que el ListView se ajuste automáticamente
                  physics:
                      ClampingScrollPhysics(), // Desactiva el desplazamiento del ListView
                  itemBuilder: (context, index) {
                    final link = event.links![index];
                    if (link == "") return Container();
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
            if (event.numParticipants != null && event.participants != null)
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
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centra los botones horizontalmente
              children: [
                SizedBox(width: 30.0),
                Expanded(
                  // Distribuye el espacio disponible uniformemente entre los botones
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: appTheme.hintColor,
                    ),
                    onPressed: () {
                      Navigator.pop(
                          context); // Cierra el diálogo y vuelve a la vista anterior
                    },
                    child: Text(
                      'Volver',
                      style: TextStyle(color: appTheme.cardColor),
                    ),
                  ),
                ),
                SizedBox(width: 30.0),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: color),
                    onPressed: () async {
                      if (isUserParticipant == 1) {
                        eventVM.removeParticipant(eventId, userId);
                      } else if (isUserParticipant == 0) {
                        eventVM.addParticipant(eventId, userId);
                      } else if (isUserParticipant == 3) {
                        // This is failing, the new form has blue foreground
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  Home(userId: userId, initialIndex: 1)),
                          (Route<dynamic> route) => false,
                        );
                        return;
                      } else {
                        print("Log :: Evento lleno");
                      }
                    },
                    child: Text(
                      texto,
                      style: TextStyle(color: appTheme.cardColor),
                    ),
                  ),
                ),
                SizedBox(width: 30.0),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ));
  }
}
