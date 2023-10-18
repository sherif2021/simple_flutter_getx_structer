import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trust_edge_task/app/config/app_binding.dart';
import 'package:trust_edge_task/app/core/error/get_failure_message.dart';
import 'package:trust_edge_task/app/core/widgets/sanckbar.dart';
import 'package:trust_edge_task/app/data/data_sources/local_data_sources/user_local_storage.dart';
import 'package:trust_edge_task/app/data/data_sources/remote_data_sources/user_remote_data_source.dart';
import 'package:trust_edge_task/app/data/models/user_model.dart';
import 'package:trust_edge_task/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final UserLocalStorage userLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  final _user = Rxn<UserModel>();

  UserModel get user => _user.value!;

  HomeController(
    this.userLocalDataSource,
    this.userRemoteDataSource,
    UserModel user,
  ) {
    _user.value = user;
  }

  void showLogoutDialog() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        logout();
      },
      onCancel: Get.back,
    );
  }

  void showDeleteAccountDialog() {
    Get.defaultDialog(
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        _deleteAccount();
      },
      onCancel: Get.back,
    );
  }

  void logout() {
    userLocalDataSource.deleteUser();
    AppBinding.attachTokenToDio('');
    Get.offAllNamed(Routes.WELCOME);
  }

  Future<void> _deleteAccount() async {
    final result = await userRemoteDataSource.deleteUser();
    result.fold(
      (failure) => showErrorSackBar(message: getFailureMessage(failure)),
      (status) {
        logout();
        showSuccessSackBar(
          message: 'Your account has been deleted successfully.',
        );
      },
    );
  }

  Future<void> getUserData() async {
    final result = await userRemoteDataSource.getUser(user.id);
    result.fold(
      (failure) => showErrorSackBar(message: getFailureMessage(failure)),
      (user) => _saveUserData(user),
    );
  }

  Future<void> _saveUserData(UserModel user) async {
    userLocalDataSource.saveUser(user);
    _user.value = user;
  }

  Future<void> onUpdateInfoPressed() async {
    final result =
        await Get.toNamed(Routes.UPDATE_INFO, arguments: user) as UserModel?;
    if (result != null) {
      _saveUserData(result);
      showSuccessSackBar(message: 'Your info has been updated successfully.');
    }
  }

  Future<void> onChangePasswordPressed() async {
    final result = await Get.toNamed(Routes.CHANGE_PASSWORD) as UserModel?;
    if (result != null) {
      getUserData();
      showSuccessSackBar(message: 'Your password updated successfully.');
    }
  }

  void checkTokenExpiry() {
    if (user.tokenExpiry!.isBefore(DateTime.now())) {
      showSessionMessageAndLogout();
    }
  }

  void showSessionMessageAndLogout() {
    showErrorSackBar(
      title: 'Session Expired',
      message: 'Your session has expired. Please login again.',
    );
    logout();
  }

  @override
  void onInit() {
    AppBinding.attachTokenToDio(user.token!);
    checkTokenExpiry();
    getUserData();
    super.onInit();
  }
}
