import 'package:flutter/material.dart';
import 'package:hive_app/view/pages/ViewsHeader.dart';
import 'package:hive_app/utils/ColorPalette.dart';

class DayPicker extends StatefulWidget {
  const DayPicker({Key? key}): super(key: key);

  @override
  _DayPickerState createState() {
    return _DayPicker();
  }
}

class _DayPicker extends State<DayPicker> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(
            "${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}",
            ),
            ElevatedButton(
              child: const Text("Elige una fecha"),
              onPressed: () async {
                final DateTime? dateTime = await showDatePicker(
                  context: context, 
                  initialDate: selectedDate, 
                  firstDate: DateTime(2000), 
                  lastDate: DateTime(2000),
                  );
                  if(dateTime != null){
                    setState(() {
                      selectedDate = dateTime;
                    });
                  }
              },
              ),
        ],
      ),
    );
  }
}



