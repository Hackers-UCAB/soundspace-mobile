part of 'user_bloc.dart';

abstract class UserEvent {}

class FetchUserProfileDataEvent extends UserEvent {
  final User user;
  final bool editable;

  FetchUserProfileDataEvent({this.editable = false, this.user = const User()});
}

class ToggleProfileEditableEvent extends UserEvent {
  final bool editable;

  ToggleProfileEditableEvent({this.editable = false});
}
