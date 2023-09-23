import 'package:flutter/material.dart';
import 'package:hive_app/view/pages/ViewsHeader.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 75),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  ViewsHeader(
                    titleText: "Lista eventos",
                  ),
                  Text(
                    "${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}",
                    style: TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    child: const Text("Elige una fecha"),
                    onPressed: () async {
                      final DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (dateTime != null) {
                        setState(() {
                          selectedDate = dateTime;
                        });
                      }
                    },
                  ),
                  Expanded(child: EventList())
                  ,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
