part of 'user_permissions_bloc.dart';

class UserPermissionsState extends Equatable {
  final bool isAuthenticated;
  final bool isSubscribed;

  const UserPermissionsState(
      {this.isAuthenticated = false, this.isSubscribed = false});

  UserPermissionsState copyWith({
    bool? isAuthenticated,
    bool? isSubscribed,
  }) =>
      UserPermissionsState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isSubscribed: isSubscribed ?? this.isSubscribed,
      );

  @override
  List<Object> get props => [isAuthenticated, isSubscribed];
}
