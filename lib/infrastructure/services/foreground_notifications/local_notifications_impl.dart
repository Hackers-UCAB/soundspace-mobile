import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../application/services/foreground_notifications/local_notifications.dart';

class LocalNotificationsImpl extends LocalNotifications {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final FirebaseMessaging _messaging;

  LocalNotificationsImpl(
      {required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      required FirebaseMessaging messaging})
      : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        _messaging = messaging;

  @override
  Future<bool> authorizationStatus() async {
    final settings = await _messaging.getNotificationSettings();
    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        return true;
      case AuthorizationStatus.denied:
        return false;
      case AuthorizationStatus.notDetermined:
        return false;
      case AuthorizationStatus.provisional:
        return false;
    }
  }

  @override
  Future<void> inicializeLocalNotifications() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> _requestPermissionLocalNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    //TODO: despues
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  Future<bool> requestPermission() async {
    //FIREBASE
    final settingsStatus = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    //LOCAL
    await _requestPermissionLocalNotifications();

    switch (settingsStatus.authorizationStatus) {
      case AuthorizationStatus.authorized:
        return true;
      case AuthorizationStatus.denied:
        return false;
      case AuthorizationStatus.notDetermined:
        return false;
      case AuthorizationStatus.provisional:
        return false;
    }
  }

  @override
  Future<void> showLocalNotifications(
      {required int id, String? title, String? body, String? data}) async {
    //TODO: CUADRAR LO DE LA IMAGEN CON HTTP
    const androidDetails = AndroidNotificationDetails(
        "channelId", "channelName",
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        icon: 'app_logo');

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      //TODO: IOS DETAILS
    );

    await _flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: data);
  }

  @override
  Future<String?> getToken() {
    return _messaging.getToken();
  }

  @override
  void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification == null) return;

      showLocalNotifications(
        id: 1,
        body: message.notification!.body ?? '',
        data: message.data
            .toString(), //TODO:Aqui hacemos el manejo de la redireccion y del caso de uso para quitar el permiso de subscriptor
        title: message.notification!.title ?? '',
      );
    });
  }
}
