import 'package:sign_in_bloc/common/result.dart';

abstract class IApiConnectionManager {
  final String baseUrl;
  IApiConnectionManager({required this.baseUrl});

  Future<Result<T>> request<T>(
      String path, String method, T Function(dynamic) mapper,
      {dynamic body, Map<String, dynamic>? queryParameters});
  void setHeaders(String key, dynamic value);
}
