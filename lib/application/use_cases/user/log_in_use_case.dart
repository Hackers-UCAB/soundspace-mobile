import 'package:sign_in_bloc/domain/user/user.dart';
import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../datasources/local/local_storage.dart';

class LogInUseCase {
  final UserRepository userRepository;
  final LocalStorage localStorage;
  LogInUseCase({required this.userRepository, required this.localStorage});

  Future<Result<User>> execute(String number) async {
    final result = await userRepository.logInUser(number);
    //TODO: Setear el resto de keys
    if (result.hasValue()) {
      await localStorage.setKeyValue('user_id', result.value!.id!.id);
      await localStorage.setKeyValue(
          'role', result.value!.role!.role.toString());
    }

    return result;
  }
}
