import 'package:dio/dio.dart';
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

    final response = await _apiConnectionManager.request<User>(
      'auth/log-in',
      'POST',
      (data) {
        data['role'] = 'subscriber';
        data['phone'] = number;
        return UserMapper.fromJson(data);
      },
      body: {'phone': number},
    );

    if (response.hasValue()) {
      _apiConnectionManager.setHeaders(
          'Authorization', 'Bearer ${response.value!.id}');
    }

    return response;
  }

  @override
  Future<Result<User>> signUpUser(
      String number, String notificationsToken, String operator) async {
    _apiConnectionManager.setHeaders('token', notificationsToken);

    final response = await _apiConnectionManager.request(
      'auth/sign-up/$operator',
      'POST',
      (data) {
        data['role'] = 'subscriber';
        data['phone'] = number;
        return UserMapper.fromJson(data);
      },
      body: {'phone': number},
    );

    if (response.hasValue()) {
      _apiConnectionManager.setHeaders(
          'Authorization', 'Bearer ${response.value!.id}');
    }

    return response;
  }

  @override
  Future<Result<User>> logInGuest() async {
    final response = await _apiConnectionManager.request(
        'auth/log-in/guest', 'POST', (data) => UserMapper.fromJson(data));

    if (response.hasValue()) {
      _apiConnectionManager.setHeaders(
          'Authorization', 'Bearer ${response.value!.id}');
    }

    return response;
  }

  @override
  Future<Result<bool>> changeUserRole() {
    final response = _apiConnectionManager.request<bool>(
      'auth/change-role', //TODO: change to correct endpoint
      'POST',
      (_) => true,
    );

    return response;
  }

  /*@override
  Future<Result<User>> fetchUserProfileData() async {
    //!TEMPORAL
    //_apiConnectionManager.setHeaders('Authorization',
    //    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE5NGY4MTc2LTY5MjktNDY5NC05NDhjLTU0OGI5OTgxNGMxMSIsImlhdCI6MTcwMzcxNTgzOCwiZXhwIjoxNzAzODAyMjM4fQ.YWZeLq9QRfKV2-VQoVDNv9vWnbTcchg13XkiUhdnk_o');
    final response = await _apiConnectionManager.request('user', 'GET');
    print("repo: " +
        response.toString() +
        " , " +
        response.value.toString() +
        " end of repo");

    if (response.hasValue()) {
      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']));
    } else {
      return Result<User>(failure: response.failure);
    }
  }

  @override
  Future<Result<User>> saveUserData(User user) async {
    //!TEMPORAL
    //_apiConnectionManager.setHeaders('Authorization',
    //    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE5NGY4MTc2LTY5MjktNDY5NC05NDhjLTU0OGI5OTgxNGMxMSIsImlhdCI6MTcwMzcxNTgzOCwiZXhwIjoxNzAzODAyMjM4fQ.YWZeLq9QRfKV2-VQoVDNv9vWnbTcchg13XkiUhdnk_o');

    final response = await _apiConnectionManager
        .request('user', 'PATCH', body: {'user': user});

    if (response.hasValue()) {
      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']));
    } else {
      return Result<User>(failure: response.failure);
    }
  }*/
}
