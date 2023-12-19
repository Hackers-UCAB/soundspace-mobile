import 'package:dio/dio.dart';
import '../../../common/error.dart';
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
      return Result(value: response, error: null);
    } on DioException catch (e) {
      return Result(error: handleException(e));
    } catch (e) {
      return Result(error: Error());
    }
  }

  Error handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return TimeOutError();
      case DioExceptionType.sendTimeout:
        return TimeOutError();
      case DioExceptionType.receiveTimeout:
        return ServerError();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return NoAuthoizedError();
        } else {
          return Error();
        }
      default:
        return Error();
    }
  }

  @override
  void setHeaders(String key, dynamic value) =>
      _dio.options.headers[key] = value;
}
