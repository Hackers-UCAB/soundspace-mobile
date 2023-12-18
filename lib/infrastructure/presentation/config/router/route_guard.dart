part of 'app_router.dart';

class AuthRouteGuard {
  final UserPermissionsBloc userPermissionsBloc;

  AuthRouteGuard({required this.userPermissionsBloc});

  bool canNavigate() => userPermissionsBloc.state.isAuthenticated == true;
}

class SubscriptionRouteGuard {
  final UserPermissionsBloc userPermissionsBloc;

  SubscriptionRouteGuard({required this.userPermissionsBloc});

  bool canNavigate() => userPermissionsBloc.state.isSubscribed == true;
}
