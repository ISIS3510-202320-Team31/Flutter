import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/view/pages/Home.dart';

import '../../models/event.model.dart';
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
  String textChanger = "futuros";
  String actualDate = '';
  int numDeEventos = 0;
  final UserVM userVM = UserVM();
  List<bool> isSelected = [
    false,
    true,
  ];

  late Future<List<Event>> cachedCalendarFuture;
  late final void Function() updateFunctionFuture;
  late Future<List<Event>> cachedCalendarPast;
  late final void Function() updateFunctionPast;

  void Function() updateFunctionFunction(
      String actualDate, String userId, String orderFuture) {
    return () {
      eventVM.fetchCalendarByUser(actualDate, userId, orderFuture);
    };
  }

  @override
  void initState() {
    super.initState();
    cachedCalendarFuture = eventVM.getLocalCalendarFuture();
    cachedCalendarPast = eventVM.getLocalCalendarPast();

    actualDate = selectedDate.toLocal().toString().split(' ')[0];

    updateFunction =
        updateFunctionFunction(actualDate, widget.userId, orderFuture);
    updateFunction();
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
                padding: EdgeInsets.fromLTRB(16, 75, 16, 0),
                child: ViewsHeader(
                  titleText: "Eventos\n$textChanger",
                ),
              ),
            ),
            Text(
              "(Tienes $numDeEventos eventos $textChanger)",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            ToggleButtons(
              children: [
                Container(
                  width: 100,
                  child: Center(
                    child: Text(
                      "Pasado",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  child: Center(
                    child: Text(
                      "Futuro",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
              isSelected: isSelected,
              onPressed: (int index) {
                if (index == 0) {
                  buttonPressed(widget.userId, "0");
                  textChanger = "pasados";
                } else {
                  buttonPressed(widget.userId, "1");
                  textChanger = "futuros";
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
                  var listener = orderFuture == '1'
                      ? viewModel.eventModelCalendarFuture.status
                      : viewModel.eventModelCalendarPast.status;
                  switch (listener) {
                    case Status.LOADING:
                      print("Log :: LOADING");
                      return FutureBuilder<List<Event>?>(future: () async {
                        if (orderFuture == '1') {
                          return cachedCalendarFuture;
                        } else {
                          return cachedCalendarPast;
                        }
                      }(), builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.hasData) {
                          numDeEventos = snapshot.data!.length;
                          return Expanded(
                              child: Column(children: [
                            Center(
                              child: LinearProgressIndicator(),
                            ),
                            Expanded(
                                child: EventList(
                                    userId: widget.userId,
                                    eventList: snapshot.data!,
                                    eventVM: eventVM,
                                    updateFunction: this.updateFunction))
                          ]));
                        } else
                          return Container();
                      });
                    case Status.OFFLINE:
                      print("Log :: OFFLINE");
                      cachedCalendarFuture = eventVM.getLocalCalendarFuture();
                      cachedCalendarPast = eventVM.getLocalCalendarPast();
                      return FutureBuilder<List<Event>>(future: () async {
                        if (orderFuture == '1') {
                          return cachedCalendarFuture;
                        } else {
                          return cachedCalendarPast;
                        }
                      }(), builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.hasData) {
                          if (snapshot.data!.length > 0) {
                            numDeEventos = snapshot.data!.length;
                            return Expanded(
                                child: Column(children: [
                              Center(
                                child: Text(
                                  "SIN INTERNET",
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
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Expanded(
                                  child: EventList(
                                userId: widget.userId,
                                eventList: snapshot.data!,
                                eventVM: eventVM,
                                updateFunction: this.updateFunction,
                              )),
                            ]));
                          } else {
                            numDeEventos = snapshot.data!.length;
                            return Expanded(
                                child: Column(children: [
                              Center(
                                child: Text(
                                  "SIN INTERNET",
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
                              SizedBox(height: 30),
                              Center(
                                child: Text(
                                  "No hay eventos.",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                            ]));
                          }
                        } else
                          return Container();
                      });
                    case Status.ERROR:
                      print("Log :: ERROR");
                      cachedCalendarFuture = eventVM.getLocalCalendarFuture();
                      cachedCalendarPast = eventVM.getLocalCalendarPast();
                      return FutureBuilder<List<Event>>(future: () async {
                        if (orderFuture == '1') {
                          return cachedCalendarFuture;
                        } else {
                          return cachedCalendarPast;
                        }
                      }(), builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.hasData) {
                          return Expanded(
                              child: Column(children: [
                            Center(
                              child: Text(
                                  "Estamos presentando errores... Intenta refrescar"),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Expanded(
                                child: EventList(
                                    userId: widget.userId,
                                    eventList: snapshot.data!,
                                    eventVM: eventVM,
                                    updateFunction: () async {
                                      if (orderFuture == '1') {
                                        return cachedCalendarFuture;
                                      } else {
                                        return cachedCalendarPast;
                                      }
                                    }))
                          ]));
                        } else
                          return Container();
                      });

                    case Status.COMPLETED:
                      print("Log :: COMPLETED");
                      eventVM.saveLocalEventsFutureCalendar();
                      eventVM.saveLocalEventsPastCalendar();
                      var eventList = orderFuture == '1'
                          ? viewModel.eventModelCalendarFuture.data!.events
                          : viewModel.eventModelCalendarPast.data!.events;
                      if (eventList.length > 0) {
                        numDeEventos = eventList.length;
                        return Expanded(
                            child: EventList(
                                userId: widget.userId,
                                eventList: eventList,
                                eventVM: eventVM,
                                updateFunction: this.updateFunction));
                      } else {
                        numDeEventos = eventList.length;
                        return Expanded(
                            child: Column(children: [
                          SizedBox(height: 30),
                          Center(
                            child: Text(
                              "No hay eventos.",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ]));
                      }
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buttonPressed(String uId, String newOrderFuture) async {
    setState(() {
      orderFuture = newOrderFuture;
      this.updateFunction =
          updateFunctionFunction(actualDate, uId, orderFuture);
      this.updateFunction();
    });
  }
}
