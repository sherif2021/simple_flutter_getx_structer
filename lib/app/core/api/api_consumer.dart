import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData;
import 'package:trust_edge_task/app/config/enums.dart';
import 'package:trust_edge_task/app/core/api/end_points.dart';
import 'package:trust_edge_task/app/core/error/exceptions.dart';
import 'package:trust_edge_task/app/modules/home/controllers/home_controller.dart';

abstract class ApiConsumer {
  void attachToken(String token);

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
  });

  Future<T> post<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  });

  Future<T> patch<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  });

  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  });
}

class ApiConsumerImpl implements ApiConsumer {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'en',
      },
    ),
  )..interceptors.addAll(
      [
        if (kDebugMode)
          LogInterceptor(
            request: true,
            responseBody: true,
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
          ),
      ],
    );

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
      );
      return response.data as T;
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      _checkIsUnAuthStatus(exception);
      throw exception;
    }
  }

  @override
  Future<T> post<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: FormData.fromMap(data ?? {}),
      );
      return response.data as T;
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      _checkIsUnAuthStatus(exception);
      throw exception;
    }
  }

  @override
  Future<T> patch<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        queryParameters: query,
        data: FormData.fromMap(data ?? {}),
      );
      return response.data as T;
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      _checkIsUnAuthStatus(exception);
      throw exception;
    }
  }

  @override
  Future<T> delete<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: query,
        data: FormData.fromMap(data ?? {}),
      );
      return response.data as T;
    } on DioException catch (e) {
      final exception = ApiException.fromDioError(e);
      _checkIsUnAuthStatus(exception);
      throw exception;
    }
  }

  @override
  void attachToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void _checkIsUnAuthStatus(ApiException exception) {
    if (exception.status == ApiResponseStatus.unauthorized &&
        Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().showSessionMessageAndLogout();
    }
  }
}
