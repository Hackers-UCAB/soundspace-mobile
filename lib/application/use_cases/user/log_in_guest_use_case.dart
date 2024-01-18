import 'package:sign_in_bloc/application/services/streaming/socket_client.dart';
import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';
import '../../datasources/local/local_storage.dart';

class LogInGuestUseCaseInput extends IUseCaseInput {}

class LogInGuestUseCase extends IUseCase<LogInGuestUseCaseInput, User> {
  final UserRepository _userRepository;
  final LocalStorage _localStorage;
  final SocketClient _socketClient;

  LogInGuestUseCase(
      {required UserRepository userRepository,
      required LocalStorage localStorage,
      required SocketClient socketClient})
      : _userRepository = userRepository,
        _localStorage = localStorage,
        _socketClient = socketClient;

  @override
  Future<Result<User>> execute(LogInGuestUseCaseInput params) async {
    final result = await _userRepository.logInGuest();
    if (result.hasValue()) {
      final user = result.value!;
      await _localStorage.setKeyValue('appToken', user.id);
      await _localStorage.setKeyValue('role', user.role.toString());

      _socketClient.updateAuth();
    }
    return result;
  }
}
