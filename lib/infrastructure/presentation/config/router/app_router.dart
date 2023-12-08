import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_bloc/application/BLoC/auth/auth_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/homePage/home_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/logIn/log_in_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/shared_widgets/no_internet_connection.dart';
import '../../pages/artistDetail/artist_detail.dart';

part 'route_guard.dart';

class AppNavigator {
  late final GoRouter _routes;
  final AuthRouteGuard authRouteGuard;
  final SubscriptionRouteGuard subscriptionRouteGuard;
  final getIt = GetIt.instance;
  AppNavigator(
      {required this.authRouteGuard, required this.subscriptionRouteGuard}) {
    _routes = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const RegisterScreen(),
          redirect: _authProtectedNavigation,
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/artist',
          builder: (context, state) => const ArtistDetail(),
          redirect: _subscriptionProtectedNavigation,
        ),
        GoRoute(
          path: '/connection-lost',
          builder: (context, state) => const NoInternetConnection(),
        )
      ],
    );
  }

  get routerDelegate {
    return _routes.routerDelegate;
  }

  get routeInformationParser {
    return _routes.routeInformationParser;
  }

  get routeInformationProvider {
    return _routes.routeInformationProvider;
  }

  void pop() {
    _routes.canPop() ? _routes.pop() : _routes.go('/');
  }

  void navigateTo(String routeName) {
    _routes.push(routeName);
  }

  void replaceWith(String routeName) {
    _routes.replace(routeName);
  }

  String? _authProtectedNavigation(BuildContext context, GoRouterState state) {
    if (authRouteGuard.canNavigate()) {
      return '/home';
    }
    return null;
  }

  String? _subscriptionProtectedNavigation(
      BuildContext context, GoRouterState state) {
    if (subscriptionRouteGuard.canNavigate()) {
      return null;
    }
    return '/home';
  }
}
