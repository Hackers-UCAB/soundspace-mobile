part of 'notifications_bloc.dart';

enum NotificationsStatus { authorized, denied, notDetermined }

class NotificationsState extends Equatable {
  final bool status;

  const NotificationsState({
    this.status = false,
  });

  NotificationsState copyWith({
    bool? status,
  }) =>
      NotificationsState(
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [status];
}
