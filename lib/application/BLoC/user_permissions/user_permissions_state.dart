part of 'user_permissions_bloc.dart';

class UserPermissionsState extends Equatable {
  final bool isAuthenticated;
  final bool isSubscribed;
  final bool validLocation;

  const UserPermissionsState(
      {this.isAuthenticated = false,
      this.isSubscribed = false,
      this.validLocation = true});

  UserPermissionsState copyWith({
    bool? isAuthenticated,
    bool? isSubscribed,
    bool? validLocation,
  }) =>
      UserPermissionsState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isSubscribed: isSubscribed ?? this.isSubscribed,
        validLocation: validLocation ?? this.validLocation,
      );

  @override
  List<Object> get props => [isAuthenticated, isSubscribed, validLocation];
}

class UserPermissionsFailed extends UserPermissionsState {
  final Failure failure;

  const UserPermissionsFailed({required this.failure});

  @override
  List<Object> get props => [failure];
}
