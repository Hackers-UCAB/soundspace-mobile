part of 'user_bloc.dart';

abstract class UserEvent {}

class FetchUserProfileDataEvent extends UserEvent {
  FetchUserProfileDataEvent();
}

class ToggleProfileEditableEvent extends UserEvent {
  final User user;
  ToggleProfileEditableEvent({required this.user});
}

class NameEditedEvent extends UserEvent {
  final User user;
  final String name;
  NameEditedEvent({required this.user, required this.name});
}

class EmailEditedEvent extends UserEvent {
  final User user;
  final String email;

  EmailEditedEvent({required this.user, required this.email});
}

class FechaEditedEvent extends UserEvent {
  final User user;
  final DateTime fecha;

  FechaEditedEvent({required this.user, required this.fecha});
}

class GenreEditedEvent extends UserEvent {
  final User user;
  final String genre;

  GenreEditedEvent({required this.user, required this.genre});
}

class CanceledSubscripcionEvent extends UserEvent {
  final User user;
  CanceledSubscripcionEvent({required this.user});
}

class SubmitChangesEvent extends UserEvent {
  final User user;
  SubmitChangesEvent({required this.user});
}
