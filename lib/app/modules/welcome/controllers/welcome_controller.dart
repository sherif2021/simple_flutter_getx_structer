import 'package:get/get.dart';
import 'package:trust_edge_task/app/routes/app_pages.dart';

class WelcomeController extends GetxController {
  void onLoginTapped() => Get.toNamed(Routes.LOGIN);

  void onRegisterTapped() => Get.toNamed(Routes.REGISTER);
}
