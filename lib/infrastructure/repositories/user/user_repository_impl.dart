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
        data['id'] = data['token'];
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
        data['id'] = data['token'];
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
    final response = await _apiConnectionManager
        .request('auth/log-in/guest', 'POST', (data) {
      data['id'] = data['token'];
      return UserMapper.fromJson(data);
    });

    if (response.hasValue()) {
      _apiConnectionManager.setHeaders(
          'Authorization', 'Bearer ${response.value!.id}');
    }

    return response;
  }

  @override
  Future<Result<bool>> changeUserRole() {
    final response = _apiConnectionManager.request<bool>(
      'subscription/cancel', //TODO: change to correct endpoint
      'POST',
      (_) => true,
    );

    return response;
  }

  @override
  Future<Result<User>> fetchUserProfileData() async {
    return await _apiConnectionManager.request<User>('user', 'GET', (data) {
      data['role'] = 'subscriber';
      return UserMapper.fromJson(data);
    });
  }

  @override
  Future<Result<String>> saveUserData(Map<String, String> userData) async {
    print(userData);
    final response = await _apiConnectionManager
        .request<String>('user', 'PATCH', (data) => 'success', body: userData);

    if (response.hasValue()) {
      return response;
    } else {
      return Result<String>(failure: response.failure);
    }
  }
}
