import 'package:sign_in_bloc/common/failure.dart';

import '../../datasources/local/local_storage.dart';
import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';

class FetchUserProfileDataUseCase {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  FetchUserProfileDataUseCase(
      {required this.userRepository, required this.localStorage});

  Future<Result<User>> execute() async {
    final result = await userRepository.fetchUserProfileData();
    //print("usecase");
    //print(result);
    //print(result.value);
    if (result.hasValue()) {
      return result;
    } else {
      return Result<User>(
          failure: const UnknownFailure(
              message:
                  'No token')); //TODO: Personalizar este error en base al Failure que retorne getToken?
    }
  }
}
