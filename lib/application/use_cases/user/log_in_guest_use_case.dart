import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';
import '../../datasources/local/local_storage.dart';

class LogInGuestUseCase {
  final UserRepository _userRepository;
  final LocalStorage _localStorage;

  LogInGuestUseCase(
      {required UserRepository userRepository,
      required LocalStorage localStorage})
      : _userRepository = userRepository,
        _localStorage = localStorage;

  Future<Result<User>> execute() async {
    final result = await _userRepository.logInGuest();
    if (result.hasValue()) {
      await _localStorage.setKeyValue('appToken', result.value!.id!.id);
      await _localStorage.setKeyValue('role', 'guest');
    }
    return result;
  }
}
