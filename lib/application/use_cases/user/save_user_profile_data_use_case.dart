import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';

class SaveUserProfileDataUseCase {
  final UserRepository userRepository;

  SaveUserProfileDataUseCase({required this.userRepository});

  Future<Result<String>> execute(Map<String, String> userData) async {
    return await userRepository.saveUserData(userData);
  }
}
