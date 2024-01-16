import 'package:sign_in_bloc/common/result.dart';
import 'package:sign_in_bloc/domain/user/user.dart';

abstract class UserRepository {
  Future<Result<User>> logInUser(String number, String notificationsToken);
  Future<Result<User>> logInGuest();
  Future<Result<User>> fetchUserProfileData();
  Future<Result<User>> signUpUser(
      String number, String notificationsToken, String operator);
  Future<Result<String>> saveUserData(Map<String, String> userData);
  Future<Result<bool>> cancelUserSubscription();
}
