import 'package:flutter/material.dart';

class OfflineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 20.0), // Adjust the padding as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              "Sin conexión a Internet",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            Text(
              "Revisa tu conexión y vuelve a intentarlo",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
