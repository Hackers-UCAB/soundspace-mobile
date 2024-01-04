import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../services/foreground_notifications/local_notifications.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  LocalNotifications localNotifications;

  NotificationsBloc({required this.localNotifications})
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listener para notificaciones en Foreground
    _onForegroundMessage();

    _setupInteractedMessage();
  }

  void _setupInteractedMessage() {
    localNotifications.setupInteractedMessage();
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
  }

  Future<void> _initialStatusCheck() async {
    final settingsStatus = await localNotifications.authorizationStatus();
    add(NotificationStatusChanged(status: settingsStatus));
  }

  void _onForegroundMessage() {
    localNotifications.onForegroundMessage();
  }

  Future<void> requestPermission() async {
    final permission = await localNotifications.requestPermission();
    add(NotificationStatusChanged(status: permission));
  }
}
