import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../application/BLoC/user_permissions/user_permissions_bloc.dart';
import '../../datasources/local/local_storage_impl.dart';
import '../../presentation/config/router/app_router.dart';

class PendingTasksManager {
  static Future<void> handlePendingTasks() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final localStorage = LocalStorageImpl(prefs: sharedPreferences);
    final pendingTask = localStorage.getValue('pendingTask');
    if (pendingTask != null) {
      switch (pendingTask) {
        case 'changeUserRole':
          final getIt = GetIt.instance;
          final userPermissionsBloc = getIt.get<UserPermissionsBloc>();
          userPermissionsBloc.add(UserPermissionsChanged(isSubscribed: false));
          getIt.get<AppNavigator>().navigateTo('/home');
          break;
        default:
      }
      await localStorage.removeKey('pendingTask');
    }
  }
}
