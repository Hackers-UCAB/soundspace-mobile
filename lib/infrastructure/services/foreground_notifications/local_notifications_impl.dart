import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
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
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    //TODO: despues
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) =>
            onDidReceiveNotificationResponse(response));

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
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) =>
            onDidReceiveNotificationResponse(response));
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
  Future<String?> getToken() async {
    //TODO: Se deberian manejar los errores de esto
    return await _messaging.getToken();
  }

  @override
  void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //TODO: aqui cae la data del message
      if (message.notification == null) return;

      showLocalNotifications(
        id: 1,
        body: message.notification!.body ?? '',
        data: message.data
            .toString(), //TODO:Aqui hacemos el manejo de la redireccion y del caso de uso para quitar el permiso de suscriptor
        title: message.notification!.title ?? '',
      );
    });
  }

  @override
  Future<void> setupInteractedMessage() async {
    await _messaging.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    handleInteractions(message.data);
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    String str = response.payload!.replaceAll(RegExp(r'[\{\}\s]'), '');
    Map<String, dynamic> map = {};

    str.split(',').forEach((part) {
      var parts = part.split(':');
      map[parts[0]] = parts[1];
    });

    handleInteractions(map);
  }

  @override
  void handleInteractions(dynamic data) {
    switch (data['action']) {
      case 'navigateTo':
        GetIt.instance.get<AppNavigator>().navigateTo(data['navigateToRoute']);
        break;
      case 'changeUserRole':
        break;
      default:
    }
  }
}
