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
        //TODO: Hay una forma de mejorar esto un pelin fumada
        await localStorage.setKeyValue('appToken', result.value!.id!.id);
        await localStorage.setKeyValue(
            'notificationsToken', notificationsToken);
        await localStorage.setKeyValue('role', 'subscriber');
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
