import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trust_edge_task/app/core/error/get_failure_message.dart';
import 'package:trust_edge_task/app/core/widgets/sanckbar.dart';
import 'package:trust_edge_task/app/data/data_sources/remote_data_sources/user_remote_data_source.dart';
import 'package:trust_edge_task/app/data/models/user_model.dart';

class UpdateInfoController extends GetxController {
  final UserRemoteDataSource userRemoteDataSource;
  final UserModel user;
  final _isLoading = Rx(false);
  final formKey = GlobalKey<FormState>();

  late final nameController = TextEditingController(
    text: user.name,
  );
  late final phoneController = TextEditingController(
    text: user.phone,
  );
  late final emailController = TextEditingController(
    text: user.email,
  );

  UpdateInfoController(this.userRemoteDataSource, this.user);

  late String countryCode = user.countryCode;

  bool get isLoading => _isLoading.value;

  Future<void> save() async {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      final result = await userRemoteDataSource.updateUser(
        user.copyWith(
          name: nameController.text,
          phone: phoneController.text,
          email: emailController.text,
          countryCode: countryCode,
        ),
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
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
