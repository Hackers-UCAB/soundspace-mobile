import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/connectivity/connectivity_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/log_out/log_out_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/notifications/notifications_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/theme/app_theme.dart';
import 'package:sign_in_bloc/infrastructure/services/config/inject_manager.dart';
import 'package:sign_in_bloc/infrastructure/services/pending_tasks_manager/pending_tasks_manager.dart';
import 'application/BLoC/player/player_bloc.dart';
import 'application/BLoC/socket/socket_bloc.dart';
import 'infrastructure/presentation/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'infrastructure/presentation/widgets/bloc_listeners/connection_listener.dart';

Future<void> main() async {
  await InjectManager.setUpInjections();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      PendingTasksManager.handlePendingTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();

    return MaterialApp.router(
      title: dotenv.env['APP_NAME']!,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerDelegate: appNavigator.routerDelegate,
      routeInformationParser: appNavigator.routeInformationParser,
      routeInformationProvider: appNavigator.routeInformationProvider,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<PlayerBloc>()),
            BlocProvider(create: (context) => getIt.get<SocketBloc>()),
            BlocProvider(create: (context) => getIt.get<UserPermissionsBloc>()),
            BlocProvider(create: (context) => getIt.get<ConnectivityBloc>()),
            BlocProvider(create: (context) => getIt.get<LogOutBloc>()),
            BlocProvider(create: (context) => getIt.get<NotificationsBloc>()),
            BlocProvider(create: (context) => getIt.get<SearchBloc>()),
          ],
          child: MultiBlocListener(
              listeners: [ConnectionListener()], child: child!),
        );
      },
    );
  }
}
