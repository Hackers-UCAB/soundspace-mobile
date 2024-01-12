part of 'user_bloc.dart';

abstract class UserEvent {}

class FetchUserProfileDataEvent extends UserEvent {
  final User user;

  FetchUserProfileDataEvent({this.user = const User()});
}

class ToggleProfileEditableEvent extends UserEvent {
  ToggleProfileEditableEvent();
}

class NameEditedEvent extends UserEvent {
  final String name;
  NameEditedEvent({required this.name});
}

class EmailEditedEvent extends UserEvent {
  final String email;
  EmailEditedEvent({required this.email});
}

class FechaEditedEvent extends UserEvent {
  final String fecha;
  FechaEditedEvent({required this.fecha});
}

class GenderEditedEvent extends UserEvent {
  final String gender;
  GenderEditedEvent({required this.gender});
}

class SubmitChangesEvent extends UserEvent {
  final User user;
  SubmitChangesEvent({required this.user});
}
