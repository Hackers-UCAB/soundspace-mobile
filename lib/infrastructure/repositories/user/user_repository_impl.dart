import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager.dart';

import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';
import '../../../infrastructure/mappers/user/user_mapper.dart';

class UserRepositoryImpl extends UserRepository {
  final IApiConnectionManager _apiConnectionManager;

  UserRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<User>> logInUser(
      String number, String notificationsToken) async {
    _apiConnectionManager.setHeaders('firebaseToken', notificationsToken);

    final response = await _apiConnectionManager
        .request('auth/login', 'POST', body: {'number': number});

    if (response.hasValue()) {
      _apiConnectionManager.setHeaders(
          'Authorization', 'Bearer ${response.value.data['data']['token']}');

      return Result<User>(value: UserMapper.fromJson(response.value.data));
    } else {
      return Result<User>(failure: response.failure);
    }
  }

  @override
  Future<Result<User>> signUpUser(
      String number, String notificationsToken, String operator) async {
    _apiConnectionManager.setHeaders('firebaseToken', notificationsToken);

    final response = await _apiConnectionManager.request('auth/sign-up', 'POST',
        body: {'value': number, 'chanelId': operator});

    if (response.hasValue()) {
      final token = response.value.data['data'];
      _apiConnectionManager.setHeaders('Authorization', 'Bearer $token');

      return Result<User>(value: UserMapper.fromJson(response.value.data));
    } else {
      return Result<User>(failure: response.failure);
    }
  }
}
