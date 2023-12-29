import 'package:sign_in_bloc/application/services/foreground_notifications/local_notifications.dart';
import 'package:sign_in_bloc/common/failure.dart';
import 'package:sign_in_bloc/domain/user/user.dart';
import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../datasources/local/local_storage.dart';

class LogInUseCaseInput extends IUseCaseInput {
  final String number;

  LogInUseCaseInput({required this.number});
}

class LogInUseCase extends IUseCase<LogInUseCaseInput, User> {
  //TODO: Poner todas estas propiedades privadas
  final UserRepository userRepository;
  final LocalStorage localStorage;
  final LocalNotifications localNotifications;
  LogInUseCase(
      {required this.userRepository,
      required this.localStorage,
      required this.localNotifications});

  @override
  Future<Result<User>> execute(LogInUseCaseInput params) async {
    final notificationsToken = await localNotifications.getToken();
    if (notificationsToken != null) {
      final result =
          await userRepository.logInUser(params.number, notificationsToken);
      if (result.hasValue()) {
        final user = result.value!;
        await localStorage.setKeyValue('appToken', user.id);
        await localStorage.setKeyValue(
            'notificationsToken', notificationsToken);
        await localStorage.setKeyValue('role', user.role.toString());
      }
      return result;
    } else {
      return Result<User>(
          failure: const UnknownFailure(
              message:
                  'No token')); //TODO: Personalizar este error en base al Failure que retorne getToken?
    }
  }
}
