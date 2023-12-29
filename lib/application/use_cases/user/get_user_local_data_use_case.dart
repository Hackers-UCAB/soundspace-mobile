import 'package:sign_in_bloc/common/failure.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../common/use_case.dart';
import '../../../domain/user/user.dart';
import '../../datasources/local/local_storage.dart';

class GetUserLocalDataUseCaseInput extends IUseCaseInput {}

class GetUserLocalDataUseCase
    extends IUseCase<GetUserLocalDataUseCaseInput, User> {
  final LocalStorage _localStorage;

  GetUserLocalDataUseCase({required LocalStorage localStorage})
      : _localStorage = localStorage;

  @override
  Future<Result<User>> execute(GetUserLocalDataUseCaseInput params) async {
    final appToken = _localStorage.getValue('appToken');
    final userRol = _localStorage.getValue('role');
    if (appToken != null && userRol != null) {
      final user = User(
        id: appToken,
        role: userRol == 'UserRoles.subscriber'
            ? UserRoles.subscriber
            : UserRoles.guest,
      );
      return Future.value(Result(value: user));
    } else {
      return Future.value(Result(failure: const NoSessionFailure()));
    }
  }
}
