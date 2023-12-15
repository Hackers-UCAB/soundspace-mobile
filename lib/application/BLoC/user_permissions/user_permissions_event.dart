part of 'user_permissions_bloc.dart';

abstract class UserPermissionsEvent {}

class UserPermissionsRequested extends UserPermissionsEvent {}

class UserPermissionsChanged extends UserPermissionsEvent {
  final bool isAuthenticated;
  final bool isSubscribed;

  UserPermissionsChanged(
      {this.isAuthenticated = false, this.isSubscribed = false});
}
