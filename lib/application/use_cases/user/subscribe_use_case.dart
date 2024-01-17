import 'package:sign_in_bloc/common/failure.dart';
import 'package:sign_in_bloc/domain/user/user.dart';
import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../datasources/local/local_storage.dart';
import '../../services/foreground_notifications/local_notifications.dart';

class SubscribeUseCaseInput extends IUseCaseInput {
  final String number;
  final String operator;

  SubscribeUseCaseInput({required this.number, required this.operator});
}

class SubscribeUseCase extends IUseCase<SubscribeUseCaseInput, User> {
  final UserRepository userRepository;
  final LocalStorage localStorage;
  final LocalNotifications localNotifications;
  SubscribeUseCase(
      {required this.userRepository,
      required this.localStorage,
      required this.localNotifications});

  @override
  Future<Result<User>> execute(SubscribeUseCaseInput params) async {
    final notificationsToken = await localNotifications.getToken();

    if (notificationsToken != null) {
      final result = await userRepository.signUpUser(
          params.number, notificationsToken, params.operator);
      if (result.hasValue()) {
        final user = result.value!;
        await localStorage.removeKey('appToken');
        await localStorage.removeKey('role');
        await localStorage.removeKey('notificationsToken');
        await localStorage.setKeyValue('appToken', user.id);
        await localStorage.setKeyValue(
            'notificationsToken', notificationsToken);
        await localStorage.setKeyValue('role', user.role.toString());
      }

      return result;
    } else {
      return Result<User>(failure: const UnknownFailure());
    }
  }
}
