import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/home/home_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/landing/landing_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/logIn/log_in_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/profile/profile_page.dart';
import '../../pages/album_detail/album_detail.dart';
import '../../pages/artist_detail/artist_detail.dart';
import '../../pages/search/search_page.dart';

part 'route_guard.dart';

class AppNavigator {
  late final GoRouter _routes;
  final AuthRouteGuard authRouteGuard;
  final SubscriptionRouteGuard subscriptionRouteGuard;
  final getIt = GetIt.instance;
  late String currentLocation;
  AppNavigator(
      {required this.authRouteGuard, required this.subscriptionRouteGuard}) {
    _routes = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) 
          {
            currentLocation = '/';
            return LandingPage();
          },
          redirect: _authProtectedNavigation,
        ),
        GoRoute(
          path: '/logIn',
          builder: (context, state) {
            currentLocation = '/logIn';
            return RegisterScreen();
          },
          redirect: _authProtectedNavigation,
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            currentLocation = '/home';
            return HomePage();
          },
        ),
        GoRoute(
          path: '/artist/:id',
          builder: (context, state) {
            final artistId = state.pathParameters['id']!;
            currentLocation = '/artist/$artistId';
            return ArtistDetail(artistId: artistId);
          },
        ),
        GoRoute(
          path: '/album/:id',
          builder: (context, state) {
            final albumId = state.pathParameters['id']!;
            currentLocation = '/album/$albumId';
            return AlbumDetail(albumId: albumId);
          },
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) {
            currentLocation = '/search';
            return SearchPage();
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) {
            currentLocation = '/profile';
            return ProfilePage();
          },
        ),
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

  void go(String routeName) {
    _routes.go(routeName);
  }

  void navigateTo(String routeName) {
    // if (subscriptionRouteGuard.canNavigate(routeName)) {
    _routes.push(routeName);
    // }
  }

  void replaceWith(String routeName) {
    _routes.replace(routeName);
  }

  String? _authProtectedNavigation(BuildContext context, GoRouterState state) {
    if (authRouteGuard.canNavigate()) {
      currentLocation = '/home';
      return '/home';
    }
    return null;
  }
}
