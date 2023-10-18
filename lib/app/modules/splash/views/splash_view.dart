import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trust_edge_task/app/config/utils/app_assets.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isClosed;
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
