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
  late String long= "0";
  final EventVM eventVM = EventVM();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isButtonPressed = false; 
  String orderFuture = "1";
  String textChanger = "Futuros";
  String actualDate = ''; 
  late final uuidUser;
  final UserVM userVM = UserVM();


  @override
  void initState() {
    uuidUser = userVM.getUserid();
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
                      height: MediaQuery.of(context).size.height*0.5,
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
      eventVM.fetchEventListByUser(actualDate, uuidUser, orderFuture);
    });
  }

  void handleNotification() async{
    _getCurrentLocation().then((value){
      lat = '${value.latitude}';
      long = '${value.longitude}';
      _liveLocation();
    });
    await initNotifications();
    await showNotification(5); 
  }

  void _liveLocation(){
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 50,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled){
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permissions are denied');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error(
        'Location permissions are permanently denied, we cannot request permission.'
      );
    }
    return await Geolocator.getCurrentPosition();
  }
}

