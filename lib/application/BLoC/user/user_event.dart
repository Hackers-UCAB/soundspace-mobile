part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

class FetchUserProfileDataEvent extends UserEvent {
  final User user;

  FetchUserProfileDataEvent({required this.user});
}
