import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../application/services/foreground_notifications/local_notifications.dart';
import 'notification_actions_manager.dart';

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
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> _requestPermissionLocalNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
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
      {required int id,
      String? title,
      String? body,
      Map<String, dynamic>? data}) async {
    const androidDetails = AndroidNotificationDetails(
        "channelId", "channelName",
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        icon: 'app_icon');

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: data.toString());
  }

  @override
  Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  @override
  void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification == null) {
        return;
      }

      NotificationActionManager.selectActionHandler(message.data, false);

      showLocalNotifications(
        id: 1,
        body: message.notification!.body ?? '',
        data: message.data,
        title: message.notification!.title ?? '',
      );
    });
  }

  @override
  Future<void> setupInteractedMessage() async {
    await _messaging.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      NotificationActionManager.selectActionHandler(message.data, true);
    });
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    final str = response.payload!.toString();
    Map<String, dynamic> map = {};

    str.split(',').forEach((part) {
      var parts = part.split(':');
      map[parts[0]] = parts[1];
    });

    NotificationActionManager.selectActionHandler(map, true);
  }
}
