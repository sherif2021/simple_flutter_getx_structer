import 'package:dartz/dartz.dart';
import 'package:trust_edge_task/app/core/api/api_consumer.dart';
import 'package:trust_edge_task/app/core/api/end_points.dart';
import 'package:trust_edge_task/app/core/error/api_error_message.dart';
import 'package:trust_edge_task/app/core/error/exceptions.dart';
import 'package:trust_edge_task/app/core/error/failure.dart';
import 'package:trust_edge_task/app/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String countryCode,
  });
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  final ApiConsumer _apiConsumer;

  AuthRemoteDataSourceImp({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _apiConsumer.post<Map<String, dynamic>>(
        EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return Right(UserModel.fromJson(result['data']));
    } on ApiException catch (e) {
      return Left(getApiFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String countryCode,
  }) async {
    try {
      final result = await _apiConsumer.post<Map<String, dynamic>>(
        EndPoints.register,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirm': confirmPassword,
          'country_code': countryCode,
        },
      );
      return Right(UserModel.fromJson(result['data']));
    } on ApiException catch (e) {
      return Left(getApiFailureFromException(e));
    }
  }
}
