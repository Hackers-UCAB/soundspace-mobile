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
  Future<Result<User>> logInUser(String number) async {
    final response = await _apiConnectionManager
        .request('auth/login', 'POST', body: {'number': number});
    // TODO: Extraer el token del response
    // _apiConnectionManager.setHeaders('Authorization', 'Bearer $token');
    if (response.hasValue()) {
      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']), error: null);
    } else {
      return Result<User>(value: null, error: response.error);
    }
  }

  @override
  Future<Result<User>> signUpUser(String number, String operator) async {
    final response = await _apiConnectionManager.request(
        'auth/validate_operator', 'POST',
        body: {'number': number, 'chanelId': operator});
    //TODO: Extraer el token del response
    //_apiConnectionManager.setHeaders('Authorization', 'Bearer $token');
    if (response.hasValue()) {
      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']), error: null);
    } else {
      return Result<User>(value: null, error: response.error);
    }
  }
}
