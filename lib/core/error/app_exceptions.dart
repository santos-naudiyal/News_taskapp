import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;

  AppException(this.message);

  factory AppException.fromDio(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return AppException('Connection timeout. Please try again.');
    }

    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode ?? 0;

      switch (statusCode) {
        case 400:
          return AppException('Bad request');
        case 401:
          return AppException('Invalid API key');
        case 429:
          return AppException('Too many requests. Try later.');
        case 500:
          return AppException('Server error');
        default:
          return AppException('Unexpected error occurred');
      }
    }

    return AppException('No internet connection');
  }

  @override
  String toString() => message;
}
