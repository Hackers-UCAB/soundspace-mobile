import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../application/services/foreground_notifications/local_notifications.dart';

class LocalNotificationsImpl extends LocalNotifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Future<void> inicializeLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  @override
  Future<void> requestPermissionLocalNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      //TODO despues
    );
  }

  @override
  Future<void> showLocalNotifications(
      {required int id, String? title, String? body, String? data}) async {
    //TODO CUADRAR LO DE LA IMAGEN CON HTTP
    const androidDetails = AndroidNotificationDetails(
        "channelId", "channelName",
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        icon: 'app_logo');

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      //TODO IOS DETAILS
    );

    await flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: data);
  }
}
