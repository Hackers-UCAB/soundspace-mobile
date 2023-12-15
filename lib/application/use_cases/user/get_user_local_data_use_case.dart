import 'package:sign_in_bloc/common/error.dart';
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
      final userId =
          localStorage.getValue('userId'); //TODO:mejorar con las .env?
      final appToken = localStorage.getValue('appToken');
      final notificationsToken = localStorage.getValue('notificationsToken');
      final userRol = localStorage.getValue('userRol');
      if (userId != null && appToken != null && notificationsToken != null) {
        return Result<User>(
            value: User(
                id: IdUser(id: userId),
                role: UserRole(
                    role: (userRol == 'guest')
                        ? UserRoles.guest
                        : UserRoles.subscriber)));
      } else {
        return Result<User>(error: NoSessionError());
      }
    } catch (e) {
      return Result<User>(error: Error());
    }
  }
}
