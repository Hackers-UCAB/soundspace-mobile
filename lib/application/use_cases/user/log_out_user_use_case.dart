import 'package:sign_in_bloc/common/use_case.dart';

import '../../../common/failure.dart';
import '../../../common/result.dart';
import '../../datasources/local/local_storage.dart';

class LogOutUserUseCaseInput extends IUseCaseInput {}

class LogOutUserUseCase extends IUseCase<LogOutUserUseCaseInput, bool> {
  final LocalStorage _localStorage;
  LogOutUserUseCase({required LocalStorage localStorage})
      : _localStorage = localStorage;

  @override
  Future<Result<bool>> execute(LogOutUserUseCaseInput params) async {
    try {
      await _localStorage.removeKey('appToken');
      await _localStorage.removeKey('role');
      return Result<bool>(value: true);
    } catch (e) {
      return Result<bool>(failure: const UnknownFailure());
    }
  }
}
