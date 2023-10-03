import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view/pages/ViewsHeader.dart';
import 'package:hive_app/services/notification_services.dart';
import 'package:provider/provider.dart';

import '../../view_model/user.vm.dart';

class Calendar extends StatefulWidget {
  static const String id = "calendar_screen";

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late String lat = "0";
  late String long = "0";
  final EventVM eventVM = EventVM();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String orderFuture = "1";
  String textChanger = "Futuros";
  String actualDate = '';
  late final uuidUser;
  final UserVM userVM = UserVM();
  List<bool> isSelected = [
    false,
    true,
  ];

  @override
  void initState() {
    uuidUser = userVM.getUserId();
    super.initState();
    super.initState();
    actualDate = selectedDate.toLocal().toString().split(' ')[0];
    eventVM.fetchEventListByUser(actualDate, uuidUser, orderFuture);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                buttonPressed("0");
                textChanger = "Pasados";
              } else {
                buttonPressed("1");
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
                  case Status.COMPLETED:
                    print("Log :: COMPLETED");
                    return Expanded(
                      child: EventList(
                          eventList: viewModel.eventModel.data!.events),
                    );
                  default:
                    return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void buttonPressed(String orderFuture) async {
    setState(() {
      eventVM.fetchEventListByUser(actualDate, uuidUser, orderFuture);
    });
  }
}
