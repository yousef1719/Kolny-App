import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message'], statusCode: statusCode);
    }
    if (statusCode == 302) {
      throw ApiError(message: 'This Email is already in use.Please login.');
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Send timeout, Please try again');
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Response timeout, Please try again');
      default:
        return ApiError(
          message: 'An unexpected error occurred. Please try again.',
        );
    }
  }
}
