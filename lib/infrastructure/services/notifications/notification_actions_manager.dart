import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/datasources/local/local_storage_impl.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';

class NotificationActionManager {
  static Map<String, Map<String, dynamic>> get actions => {
        'navigateTo': {
          'handler': _navigateToHandler,
          'needsInteraction': true,
        },
        'changeUserRole': {
          'handler': _changeUserRoleHandler,
          'needsInteraction': false,
        },
      };

  static void selectActionHandler(
      Map<String, dynamic> data, bool needsInteraction) {
    final action = data['action'];

    for (var key in actions.keys) {
      if (key == action &&
          actions[key]!['needsInteraction'] == needsInteraction) {
        actions[key]!['handler'](data);
      }
    }
  }

  static _changeUserRoleHandler(Map<String, dynamic> data) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final localStorage = LocalStorageImpl(prefs: sharedPreferences);
    final getIt = GetIt.instance;
    localStorage.setKeyValue('role', 'guest');
    if (getIt.isRegistered<UserPermissionsBloc>()) {
      getIt
          .get<UserPermissionsBloc>()
          .add(UserPermissionsChanged(isSubscribed: false));
      getIt.get<AppNavigator>().navigateTo('/home');
    }
  }

  static _navigateToHandler(Map<String, dynamic> data) {
    final navigator = GetIt.instance.get<AppNavigator>();
    print('navigateTo: ${data['navigateToRoute']}]}');
    navigator.navigateTo(data['navigateToRoute']);
  }
}
