import 'package:sign_in_bloc/application/datasources/local/local_storage.dart';
import 'package:sign_in_bloc/common/result.dart';
import 'package:sign_in_bloc/common/use_case.dart';
import 'package:sign_in_bloc/domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';

class ChangeUserRoleUseCaseInput extends IUseCaseInput {
  final User user;

  ChangeUserRoleUseCaseInput({required this.user});
}

class ChangeUserRoleUseCase extends IUseCase<ChangeUserRoleUseCaseInput, bool> {
  final UserRepository _userRepository;
  final LocalStorage _localStorage;

  ChangeUserRoleUseCase(
      {required UserRepository userRepository,
      required LocalStorage localStorage})
      : _userRepository = userRepository,
        _localStorage = localStorage;

  @override
  Future<Result<bool>> execute(ChangeUserRoleUseCaseInput params) async {
    final result = await _userRepository.changeUserRole();
    if (result.hasValue()) {
      _localStorage.setKeyValue('role', 'guest');
    }
    return result;
  }
}
