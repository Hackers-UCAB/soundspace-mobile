import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';

class FetchUserProfileDataUseCase {
  final UserRepository userRepository;

  FetchUserProfileDataUseCase({required this.userRepository});

  Future<Result<User>> execute() async {
    return await userRepository.fetchUserProfileData();
  }
}
