import 'package:dartz/dartz.dart';
import 'package:trust_edge_task/app/core/api/api_consumer.dart';
import 'package:trust_edge_task/app/core/api/end_points.dart';
import 'package:trust_edge_task/app/core/error/api_error_message.dart';
import 'package:trust_edge_task/app/core/error/exceptions.dart';
import 'package:trust_edge_task/app/core/error/failure.dart';
import 'package:trust_edge_task/app/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, UserModel>> getUser(String id);

  Future<Either<Failure, UserModel>> updateUser(UserModel user);

  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  });

  Future<Either<Failure, bool>> deleteUser();
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  final ApiConsumer _apiConsumer;

  UserRemoteDataSourceImp({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  Future<Either<Failure, UserModel>> getUser(String id) async {
    try {
      final result = await _apiConsumer.get<Map<String, dynamic>>(
        '${EndPoints.getUser}$id',
      );
      return Right(UserModel.fromJson(result['data']));
    } on ApiException catch (e) {
      return Left(getApiFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(UserModel user) async {
    try {
      final result = await _apiConsumer.post<Map<String, dynamic>>(
        EndPoints.updateUser,
        data: user.toJson(),
      );
      return Right(UserModel.fromJson(result['data']));
    } on ApiException catch (e) {
      return Left(getApiFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      await _apiConsumer.post<Map<String, dynamic>>(
        EndPoints.changePassword,
        data: {
          'current_password': oldPassword,
          'password': newPassword,
          'password_confirm': confirmNewPassword,
        },
      );
      return const Right(true);
    } on ApiException catch (e) {
      return Left(getApiFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser() async {
    try {
      await _apiConsumer.delete(EndPoints.deleteUser);
      return const Right(true);
    } on ApiException catch (e) {
      return Left(getApiFailureFromException(e));
    }
  }
}
