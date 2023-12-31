import 'package:dio/dio.dart';
import '../../../common/failure.dart';
import '../../../common/result.dart';
import 'api_connection_manager.dart';

class ApiConnectionManagerImpl extends IApiConnectionManager {
  final Dio _dio;

  ApiConnectionManagerImpl({
    required super.baseUrl,
  }) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  Future<Result> request(String path, String method, {dynamic body}) async {
    try {
      final response = await _dio.request(path,
          data: body, options: Options(method: method));
      return Result(value: response);
    } on DioException catch (e) {
      return Result(failure: handleException(e));
    } catch (e) {
      return Result(failure: UnknownFailure(message: e.toString()));
    }
  }

  Failure handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType
                .connectionTimeout || //TODO: Ver si todo esto se relaciona a fallas de internet
            DioExceptionType.sendTimeout ||
            DioExceptionType.receiveTimeout:
        return const NoInternetFailure();
      case DioExceptionType
            .badResponse: //TODO: Esto no siempre es porque no este autorizado, definir el resto de Failures
        return NoAuthorizeFailure(message: e.response?.data['message']);
      default:
        return UnknownFailure(message: e.toString());
    }
  }

  @override
  void setHeaders(String key, dynamic value) =>
      _dio.options.headers[key] = value;
}
