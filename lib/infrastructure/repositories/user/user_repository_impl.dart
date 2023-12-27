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
    _apiConnectionManager.setHeaders('token', notificationsToken);

    final response = await _apiConnectionManager
        .request('auth/log-in', 'POST', body: {'phone': number});

    if (response.hasValue()) {
      _apiConnectionManager.setHeaders(
          'Authorization', 'Bearer ${response.value.data['data']['token']}');

      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']));
    } else {
      return Result<User>(failure: response.failure);
    }
  }

  @override
  Future<Result<User>> signUpUser(
      String number, String notificationsToken, String operator) async {
    _apiConnectionManager.setHeaders('token', notificationsToken);

    final response = await _apiConnectionManager
        .request('auth/sign-up/$operator', 'POST', body: {'phone': number});

    if (response.hasValue()) {
      final token = response.value.data['data']['token'];
      _apiConnectionManager.setHeaders('Authorization', 'Bearer $token');

      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']));
    } else {
      return Result<User>(failure: response.failure);
    }
  }

  @override
  Future<Result<User>> logInGuest() async {
    final response =
        await _apiConnectionManager.request('auth/log-in/guest', 'POST');

    if (response.hasValue()) {
      final token = response.value.data['data']['token'];
      _apiConnectionManager.setHeaders('Authorization', 'Bearer $token');

      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']));
    } else {
      return Result<User>(failure: response.failure);
    }
  }

  //! arreglar
  @override
  Future<Result<User>> fetchUserProfileData() async {
    final response =
        await _apiConnectionManager.request('user/profileData', 'GET');

    if (response.hasValue()) {
      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']));
    } else {
      return Result<User>(failure: response.failure);
    }
  }
}
