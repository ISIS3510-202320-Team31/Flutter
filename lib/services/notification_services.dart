import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('icon_notification');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

}

Future<void> showNotification(String location) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('HIVE', 'hive_channel',
          importance: Importance.max, priority: Priority.high);

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  // Crear el texto de la notificación con la variable X
  String notificationText =
      'Hemos detectado que estás $location hay muchos eventos esperandote.';

  await flutterLocalNotificationsPlugin.show(1, '¡Eventos cercanos encontrados!',
      notificationText, notificationDetails);
      
}