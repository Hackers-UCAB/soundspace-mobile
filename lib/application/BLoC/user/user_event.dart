part of 'user_bloc.dart';

abstract class UserEvent {}

class FetchUserProfileDataEvent extends UserEvent {
  final User user;

  FetchUserProfileDataEvent({this.user = const User()});
}

class ToggleProfileEditableEvent extends UserEvent {
  ToggleProfileEditableEvent();
}

class EditingFechaEvent extends UserEvent {
  final DateTime fecha;
  EditingFechaEvent({required this.fecha});
}
