import 'package:sign_in_bloc/application/services/foreground_notifications/local_notifications.dart';
import 'package:sign_in_bloc/common/failure.dart';

import '../../datasources/local/local_storage.dart';
import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';

class SaveUserProfileDataUseCase {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  SaveUserProfileDataUseCase(
      {required this.userRepository, required this.localStorage});

  Future<Result<User>> execute(User user) async {
    return Result<User>(failure: const UnknownFailure(message: 'No token'));
    /*final result = await userRepository.saveUserData(user);
    if (result.hasValue()) {
      return result;
    } else {
      return Result<User>(
          failure:
              const UnknownFailure(message: "Couldn't save user profile data"));
    }
  */
  }
}
