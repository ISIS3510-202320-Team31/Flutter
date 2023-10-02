import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view/pages/ViewsHeader.dart';
import 'package:hive_app/services/notification_services.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  static const String id = "calendar_screen";

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final EventVM eventVM = EventVM();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isButtonPressed = false; 
  String orderFuture = "1";
  String textChanger = "Futuros";

  @override
  void initState() {
    String date = "01:10:2023";
        // eventVM.getUUID? Como extraigo el uuid??
    String uuidUser = "1";
    super.initState();
    eventVM.fetchEventListByUser(date, uuidUser, orderFuture);
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
          ElevatedButton(
            onPressed: buttonPressed,
            child: Text(isButtonPressed ? 'Cambiar: Eventos Futuros' : 'Cambiar: Eventos Pasados'), // Cambiar el texto del botón
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02),
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
                      height: MediaQuery.of(context).size.height*0.7,
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
                      child: EventList(eventList: viewModel.eventModel.data!.events),
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

  void buttonPressed() async {
    setState(() {
      orderFuture = isButtonPressed ? "1" : "0"; 
      textChanger = isButtonPressed ? "Futuros" : "Pasados"; 
      isButtonPressed = !isButtonPressed;
      handleNotification();
    });
  }

  void handleNotification() async{
    await initNotifications();
    await showNotification(5); 
  }
}