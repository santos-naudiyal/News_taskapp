import 'package:dio/dio.dart';
import 'package:news_app/core/error/app_exceptions.dart';


class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..responseType = ResponseType.json;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: query,
      );
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    }
  }
}
