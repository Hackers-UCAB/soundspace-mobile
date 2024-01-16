import 'package:sign_in_bloc/application/datasources/local/local_storage.dart';
import 'package:sign_in_bloc/common/result.dart';
import 'package:sign_in_bloc/common/use_case.dart';
import 'package:sign_in_bloc/domain/user/repository/user_repository.dart';

class CancelSubscriptionUseCaseInput extends IUseCaseInput {}

class CancelSubscriptionUseCase
    extends IUseCase<CancelSubscriptionUseCaseInput, bool> {
  final UserRepository _userRepository;
  final LocalStorage _localStorage;

  CancelSubscriptionUseCase(
      {required UserRepository userRepository,
      required LocalStorage localStorage})
      : _userRepository = userRepository,
        _localStorage = localStorage;

  @override
  Future<Result<bool>> execute(CancelSubscriptionUseCaseInput params) async {
    final result = await _userRepository.cancelUserSubscription();
    if (result.hasValue()) {
      _localStorage.setKeyValue('role', 'guest');
    }
    return result;
  }
}
