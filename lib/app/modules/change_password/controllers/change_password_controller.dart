import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trust_edge_task/app/core/error/get_failure_message.dart';
import 'package:trust_edge_task/app/core/widgets/sanckbar.dart';
import 'package:trust_edge_task/app/data/data_sources/remote_data_sources/user_remote_data_source.dart';

class ChangePasswordController extends GetxController {
  final UserRemoteDataSource _userRemoteDataSource;

  final _isLoading = Rx(false);
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ChangePasswordController(this._userRemoteDataSource);

  bool get isLoading => _isLoading.value;

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      final result = await _userRemoteDataSource.changePassword(
        oldPassword: oldPasswordController.text.trim(),
        newPassword: passwordController.text.trim(),
        confirmNewPassword: confirmPasswordController.text.trim(),
      );
      _isLoading.value = false;
      result.fold(
        (l) => showErrorSackBar(
          title: getFailureTitle(l),
          message: getFailureMessage(l),
        ),
        (user) async {
          Get.back(result: user);
        },
      );
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
