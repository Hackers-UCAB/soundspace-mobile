import 'package:sign_in_bloc/common/failure.dart';
import 'package:sign_in_bloc/common/result.dart';
import '../../../domain/user/user.dart';
import '../../../domain/user/valueObjects/id_user_value_object.dart';
import '../../../domain/user/valueObjects/user_role_value_object.dart';
import '../../datasources/local/local_storage.dart';

class GetUserLocalDataUseCase {
  final LocalStorage localStorage;

  GetUserLocalDataUseCase({required this.localStorage});

  Result<User> execute() {
    try {
      final appToken = localStorage.getValue('appToken');
      final notificationsToken = localStorage.getValue('notificationsToken');
      final userRol = localStorage.getValue('role');
      if (appToken != null && notificationsToken != null) {
        return Result<User>(
            value: User(
                id: IdUser(id: appToken),
                role: UserRole(
                    role: (userRol == 'guest')
                        ? UserRoles.guest
                        : UserRoles.subscriber)));
      } else {
        return Result<User>(failure: const NoSessionFailure());
      }
    } catch (e) {
      return Result<User>(failure: const NoSessionFailure());
    }
  }
}
