import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trust_edge_task/app/core/error/get_failure_message.dart';
import 'package:trust_edge_task/app/core/widgets/sanckbar.dart';
import 'package:trust_edge_task/app/data/data_sources/local_data_sources/user_local_storage.dart';
import 'package:trust_edge_task/app/data/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:trust_edge_task/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final UserLocalStorage _userLocalStorage;
  final AuthRemoteDataSource _authRemoteDataSource;
  final _isLoading = Rx(false);
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool get isLoading => _isLoading.value;

  LoginController(
    this._authRemoteDataSource,
    this._userLocalStorage,
  );

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      final result = await _authRemoteDataSource.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      result.fold(
        (l) => showErrorSackBar(
          title: getFailureTitle(l),
          message: getFailureMessage(l),
        ),
        (user) async {
          await _userLocalStorage.saveUser(user);
          Get.offAllNamed(Routes.HOME, arguments: user);
        },
      );
      _isLoading.value = false;
    }
  }

  void onRegisterTapped() => Get.toNamed(Routes.REGISTER);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
