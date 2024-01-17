import 'package:sign_in_bloc/application/services/foreground_notifications/local_notifications.dart';
import 'package:sign_in_bloc/common/failure.dart';
import 'package:sign_in_bloc/domain/user/user.dart';
import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../datasources/local/local_storage.dart';
import '../../services/streaming/socket_client.dart';

class LogInUseCaseInput extends IUseCaseInput {
  final String number;

  LogInUseCaseInput({required this.number});
}

class LogInUseCase extends IUseCase<LogInUseCaseInput, User> {
  final UserRepository userRepository;
  final LocalStorage localStorage;
  final LocalNotifications localNotifications;
  final SocketClient socketClient;

  LogInUseCase(
      {required this.userRepository,
      required this.localStorage,
      required this.localNotifications,
      required this.socketClient});

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

        if (socketClient.isDisconnected()) {
          socketClient.inicializeSocket();
        } else if (socketClient.isInitializated()) {
          socketClient.disconnectSocket();
          socketClient.inicializeSocket();
        }
      }
      return result;
    } else {
      return Result<User>(failure: const UnknownFailure());
    }
  }
}
