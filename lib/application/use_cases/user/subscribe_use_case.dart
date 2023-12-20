import 'package:sign_in_bloc/domain/user/user.dart';
import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../datasources/local/local_storage.dart';
import '../../services/foreground_notifications/local_notifications.dart';

class SubscribeUseCase {
  final UserRepository userRepository;
  final LocalStorage localStorage;
  final LocalNotifications localNotifications;
  SubscribeUseCase(
      {required this.userRepository,
      required this.localStorage,
      required this.localNotifications});

  Future<Result<User>> execute(String number, String operator) async {
    final notificationsToken = await localNotifications.getToken();

    if (notificationsToken != null) {
      final result =
          await userRepository.signUpUser(number, notificationsToken, operator);
      if (result.hasValue()) {
        //TODO: Hay una forma de mejorar esto un pelin fumada
        await localStorage.setKeyValue('appToken', result.value!.id!.id);
        await localStorage.setKeyValue(
            'notificationsToken', notificationsToken);
        await localStorage.setKeyValue('role', 'subscriber');
      }

      return result;
    } else {
      return Result<User>(error: Error());
    }
  }
}
