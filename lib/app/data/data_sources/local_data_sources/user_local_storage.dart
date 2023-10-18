import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trust_edge_task/app/config/constants.dart';
import 'package:trust_edge_task/app/core/error/failure.dart';
import 'package:trust_edge_task/app/data/models/user_model.dart';

abstract class UserLocalStorage {
  Future<Either<Failure, UserModel?>> getUser();

  Future<Either<Failure, UserModel>> saveUser(UserModel user);

  Future<Either<Failure, bool>> deleteUser();
}

class UserLocalStorageImp extends UserLocalStorage {
  final FlutterSecureStorage storage;

  UserLocalStorageImp({required this.storage});

  @override
  Future<Either<Failure, bool>> deleteUser() async {
    try {
      await storage.delete(key: Constants.userKeyStorage);
      return const Right(true);
    } catch (e) {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getUser() async {
    try {
      final data = await storage.read(key: Constants.userKeyStorage);
      return Right(data != null ? UserModel.fromJson(jsonDecode(data)) : null);
    } catch (e) {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> saveUser(UserModel user) async {
    try {
      UserModel? oldUser;
      final oldUserData = await storage.read(key: Constants.userKeyStorage);
      if (oldUserData != null) {
        oldUser = UserModel.fromJson(jsonDecode(oldUserData));
      }
      final newUser = oldUser != null && user.token == null
          ? user.copyWith(
              token: oldUser.token,
              tokenExpiry: oldUser.tokenExpiry,
            )
          : user;
      await storage.write(
        key: Constants.userKeyStorage,
        value: jsonEncode(newUser.toJson()),
      );
      return Right(newUser);
    } catch (e) {
      return Left(LocalStorageFailure());
    }
  }
}
