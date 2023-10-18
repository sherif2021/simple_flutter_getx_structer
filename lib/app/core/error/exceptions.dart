import 'package:dio/dio.dart';
import 'package:trust_edge_task/app/config/enums.dart';

class LocalStorageException implements Exception {}

class CustomException implements Exception {
  final String message;

  CustomException(this.message);
}

class ApiException implements Exception {
  final ApiResponseStatus status;
  final String? message;
  final String? error;
  final List? errors;

  const ApiException({
    required this.status,
    this.message,
    this.error,
    this.errors,
  });

  factory ApiException.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException(
          status: ApiResponseStatus.serverError,
          message: e.message,
        );
      default:
        return ApiException(
          status: ApiResponseStatus.values.firstWhere(
            (ex) => ex.code == e.response?.statusCode,
            orElse: () => ApiResponseStatus.unknownError,
          ),
          message: e.response?.data['message'] as String?,
          error: e.response?.data['error'] as String?,
          errors: e.response?.data['data'] as List?,
        );
    }
  }
}
