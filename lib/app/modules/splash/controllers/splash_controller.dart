import 'package:get/get.dart';
import 'package:trust_edge_task/app/data/data_sources/local_data_sources/user_local_storage.dart';
import 'package:trust_edge_task/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final UserLocalStorage _localStorage;

  SplashController({
    required UserLocalStorage localStorage,
  }) : _localStorage = localStorage;

  Future<void> _checkIsLoggedIn() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = await _localStorage.getUser();

    user.fold(
      (l) => _navToWelcome(),
      (user) {
        if (user != null) {
          Get.offNamed(Routes.HOME, arguments: user);
        } else {
          _navToWelcome();
        }
      },
    );
  }

  void _navToWelcome() {
    Get.offNamed(Routes.WELCOME);
  }

  @override
  void onInit() {
    _checkIsLoggedIn();
    super.onInit();
  }
}
