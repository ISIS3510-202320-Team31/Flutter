import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
  final UserVM userVM = UserVM();
  int currentSelected = 1;

  late Future<List<Event>> storedCalendarFuture;
  late final void Function() updateFunctionFuture;
  late Future<List<Event>> storedCalendarPast;
  late final void Function() updateFunctionPast;
  late Future<List<Event>> storedCalendarByOwner;
  late final void Function() updateFunctionByOwner;

  void Function() updateFunctionFunction(
      String actualDate, String userId, String orderFuture) {
    return () {
      if (orderFuture == '2')
        eventVM.fetchEventsByOwner(userId);
      else
        eventVM.fetchCalendarByUser(actualDate, userId, orderFuture);
    };
  }

  @override
  void initState() {
    super.initState();
    storedCalendarFuture = eventVM.getLocalCalendarFuture();
    storedCalendarPast = eventVM.getLocalCalendarPast();
    storedCalendarByOwner = eventVM.getLocalEventsByOwner();

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
          MaterialPageRoute(
              builder: (context) =>
                  Home(userId: widget.userId, initialIndex: 0)),
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
            SizedBox(height: 15),
            ToggleSwitch(
              initialLabelIndex: currentSelected,
              totalSwitches: 3,
              minWidth: MediaQuery.of(context).size.width * 0.9,
              inactiveBgColor: Color.fromARGB(100, 255, 255, 255),
              activeBgColor: [Colors.blue],
              labels: ['Historial', 'Actividades', 'Tus Eventos'],
              onToggle: (index) {
                if (index == 0) {
                  buttonPressed(widget.userId, "0");
                  textChanger = "pasados";
                } else if (index == 1) {
                  buttonPressed(widget.userId, "1");
                  textChanger = "futuros";
                } else {
                  buttonPressed(widget.userId, "2");
                  textChanger = "tuyos";
                }
                setState(() {
                  currentSelected = index!;
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ChangeNotifierProvider<EventVM>(
              create: (BuildContext context) => eventVM,
              child: Consumer<EventVM>(
                builder: (context, viewModel, _) {
                  var listener;
                  if (orderFuture == '0')
                    listener = viewModel.eventModelCalendarPast.status;
                  else if (orderFuture == '1')
                    listener = viewModel.eventModelCalendarFuture.status;
                  else if (orderFuture == '2')
                    listener = viewModel.eventModelByOwner.status;
                  switch (listener) {
                    case Status.LOADING:
                      print("Log :: LOADING");
                      return FutureBuilder<List<Event>?>(future: () async {
                        if (orderFuture == '0') {
                          return storedCalendarPast;
                        } else if (orderFuture == '1') {
                          return storedCalendarFuture;
                        } else {
                          return storedCalendarByOwner;
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
                      storedCalendarFuture = eventVM.getLocalCalendarFuture();
                      storedCalendarPast = eventVM.getLocalCalendarPast();
                      storedCalendarByOwner = eventVM.getLocalEventsByOwner();
                      return FutureBuilder<List<Event>>(future: () async {
                        if (orderFuture == '0') {
                          return storedCalendarPast;
                        } else if (orderFuture == '1') {
                          return storedCalendarFuture;
                        } else {
                          return storedCalendarByOwner;
                        }
                      }(), builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.hasData) {
                          if (snapshot.data!.length > 0) {
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
                              Text(
                                "Tienes ${snapshot.data!.length} eventos",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
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
                      storedCalendarFuture = eventVM.getLocalCalendarFuture();
                      storedCalendarPast = eventVM.getLocalCalendarPast();
                      storedCalendarByOwner = eventVM.getLocalEventsByOwner();
                      return FutureBuilder<List<Event>>(future: () async {
                        if (orderFuture == '0') {
                          return storedCalendarPast;
                        } else if (orderFuture == '1') {
                          return storedCalendarFuture;
                        } else {
                          return storedCalendarByOwner;
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
                                      if (orderFuture == '0') {
                                        return storedCalendarPast;
                                      } else if (orderFuture == '1') {
                                        return storedCalendarFuture;
                                      } else {
                                        return storedCalendarByOwner;
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
                      eventVM.saveLocalEventsByOwner();
                      var eventList;
                      if (orderFuture == '0')
                        eventList =
                            viewModel.eventModelCalendarPast.data!.events;
                      else if (orderFuture == '1')
                        eventList =
                            viewModel.eventModelCalendarFuture.data!.events;
                      else
                        eventList = viewModel.eventModelByOwner.data!.events;
                      if (eventList.length > 0) {
                        return Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Tienes ${eventList.length} eventos",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Expanded(
                                  child: EventList(
                                      userId: widget.userId,
                                      eventList: eventList,
                                      eventVM: eventVM,
                                      updateFunction: this.updateFunction))
                            ],
                          ),
                        );
                      } else {
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
