import '../../../common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';
import '../../datasources/local/local_storage.dart';

class LogInGuestUseCaseInput extends IUseCaseInput {}

class LogInGuestUseCase extends IUseCase<LogInGuestUseCaseInput, User> {
  final UserRepository _userRepository;
  final LocalStorage _localStorage;

  LogInGuestUseCase(
      {required UserRepository userRepository,
      required LocalStorage localStorage})
      : _userRepository = userRepository,
        _localStorage = localStorage;

  @override
  Future<Result<User>> execute(LogInGuestUseCaseInput params) async {
    final result = await _userRepository.logInGuest();
    if (result.hasValue()) {
      await _localStorage.setKeyValue('appToken', result.value!.id!.id);
      await _localStorage.setKeyValue('role', 'guest');
    }
    return result;
  }
}
