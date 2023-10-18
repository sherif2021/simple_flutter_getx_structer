import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trust_edge_task/app/config/utils/app_assets.dart';
import 'package:trust_edge_task/app/config/utils/app_colors.dart';
import 'package:trust_edge_task/app/config/utils/app_text_styles.dart';
import 'package:trust_edge_task/app/core/widgets/custom_button.dart';
import 'package:trust_edge_task/app/core/widgets/custom_material_button.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            AppAssets.logo,
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome to the app',
            style: AppTextStyles.titleTextStyle,
          ),
          const Spacer(flex: 2),
          CustomMaterialButton(
            title: 'Login',
            width: 300,
            onPressed: controller.onLoginTapped,
          ),
          const SizedBox(height: 20),
          CustomOutlinedButton(
            title: 'Register',
            width: 300,
            onPressed: controller.onRegisterTapped,
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Designed & Developed by '),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Ali Fouad',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
