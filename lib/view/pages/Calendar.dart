import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';
import 'package:hive_app/view/pages/Home.dart';
//import 'package:hive_app/services/notification_services.dart';
import 'package:provider/provider.dart';

import '../../view_model/user.vm.dart';

class Calendar extends StatefulWidget {
  static const String id = "calendar_screen";

  final String userId;
  Calendar({required this.userId});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late String lat = "0";
  late String long = "0";
  late var updateFunction;
  final EventVM eventVM = EventVM();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String orderFuture = "1";
  String textChanger = "Futuros";
  String actualDate = '';
  final UserVM userVM = UserVM();
  List<bool> isSelected = [
    false,
    true,
  ];

  void Function() updateFunctionFunction(
      String actualDate, String userId, String orderFuture) {
    return () {
      eventVM.fetchEventListByUser(actualDate, userId, orderFuture);
    };
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    actualDate = selectedDate.toLocal().toString().split(' ')[0];

    this.updateFunction =
        updateFunctionFunction(actualDate, widget.userId, orderFuture);
    this.updateFunction();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(userId: widget.userId)),
        );
        return true;
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
          ),
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 75, 30, 0),
                child: ViewsHeader(
                  titleText: "Eventos\n$textChanger",
                ),
              ),
            ),
            ToggleButtons(
              children: [
                Container(
                  width: 100,
                  child: Center(child: Text("Pasado")),
                ),
                Container(
                  width: 100,
                  child: Center(child: Text("Futuro")),
                ),
              ],
              isSelected: isSelected,
              onPressed: (int index) {
                if (index == 0) {
                  buttonPressed(widget.userId, "0");
                  textChanger = "Pasados";
                } else {
                  buttonPressed(widget.userId, "1");
                  textChanger = "Futuros";
                }
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] =
                        (i == index); // Activa solo el ícono seleccionado
                  }
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ChangeNotifierProvider<EventVM>(
              create: (BuildContext context) => eventVM,
              child: Consumer<EventVM>(
                builder: (context, viewModel, _) {
                  switch (viewModel.eventModel.status) {
                    case Status.LOADING:
                      print("Log :: LOADING");
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                        height: MediaQuery.of(context).size.height * 0.5,
                      );
                    case Status.ERROR:
                      print("Log :: ERROR");
                      return Container(
                        child: Center(
                          child: Text("Error"),
                        ),
                      );
                    case Status.OFFLINE:
                      print("Log :: OFFLINE");
                      return Expanded(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "SIN CONEXIÓN A INTERNET",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Revisa tu conexión y refresca la página",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case Status.COMPLETED:
                      print("Log :: COMPLETED");
                      return Expanded(
                        child: EventList(
                            userId: widget.userId,
                            eventList: viewModel.eventModel.data!.events,
                            eventVM: eventVM,
                            updateFunction: this.updateFunction),
                      );
                    default:
                      return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void buttonPressed(String uId, String orderFuture) async {
    setState(() {
      this.updateFunction =
          updateFunctionFunction(actualDate, uId, orderFuture);
      this.updateFunction();
    });
  }
}
