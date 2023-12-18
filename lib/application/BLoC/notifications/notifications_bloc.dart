import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../services/foreground_notifications/local_notifications.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

//TODO: mandar la config de permiso de las local por constructor como inversion de dependencias
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  LocalNotifications localNotifications;

  NotificationsBloc({required this.localNotifications})
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listener para notificaciones en Foreground
    _onForegroundMessage();
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print('aquiiiii $token');
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    localNotifications.showLocalNotifications(
      id: 1,
      body: message.notification!.body ?? '',
      data: message.data.toString(),
      title: message.notification!.title ?? '',
    );
  }

  void _onForegroundMessage() {
    _getFCMToken();
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  //TODO:esto se deberia hacer una sola vez al iniciar la app
  void requestPermission() async {
    //FIREBASE
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    await localNotifications.requestPermissionLocalNotifications();

    add(NotificationStatusChanged(settings.authorizationStatus));
  }
}
