import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trust_edge_task/app/core/error/get_failure_message.dart';
import 'package:trust_edge_task/app/core/widgets/sanckbar.dart';
import 'package:trust_edge_task/app/data/data_sources/local_data_sources/user_local_storage.dart';
import 'package:trust_edge_task/app/data/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:trust_edge_task/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final UserLocalStorage _userLocalStorage;
  final AuthRemoteDataSource _authRemoteDataSource;
  final _isLoading = Rx(false);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String countryCode = '';

  bool get isLoading => _isLoading.value;

  RegisterController(
    this._authRemoteDataSource,
    this._userLocalStorage,
  );

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      final result = await _authRemoteDataSource.register(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        countryCode: countryCode.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
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
  void onLoginTapped() => Get.toNamed(Routes.LOGIN);

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
