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

    if (result.hasValue()) {
      await localStorage.setKeyValue('appToken', result.value!.id!.id);
    }

    return result;
  }
}
