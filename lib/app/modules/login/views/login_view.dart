import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trust_edge_task/app/config/utils/app_assets.dart';
import 'package:trust_edge_task/app/config/utils/app_colors.dart';
import 'package:trust_edge_task/app/config/utils/app_text_styles.dart';
import 'package:trust_edge_task/app/config/validators.dart';
import 'package:trust_edge_task/app/core/widgets/custom_material_button.dart';
import 'package:trust_edge_task/app/core/widgets/custom_text_form_field.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              SizedBox(height: height * .1),
              Image.asset(
                AppAssets.logo,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              SizedBox(height: height * .02),
              const Text(
                'Login',
                style: AppTextStyles.titleTextStyle,
              ),
              SizedBox(height: height * .15),
              CustomFormTextField(
                hintText: 'Email Address',
                controller: controller.emailController,
                validator: Validators.emailValidator,
                maxLines: 1,
                textInputType: TextInputType.emailAddress,
                width: 300,
              ),
              SizedBox(height: height * .03),
              ValueBuilder<bool?>(
                initialValue: true,
                builder: (value, update) => CustomFormTextField(
                  hintText: 'Password',
                  controller: controller.passwordController,
                  validator: Validators.passwordValidator,
                  secure: value!,
                  maxLines: 1,
                  width: 300,
                  textInputType: TextInputType.visiblePassword,
                  onSubmit: (v) => controller.login(),
                  suffixIcon: IconButton(
                    icon: Icon(value ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => update(!value),
                  ),
                ),
              ),
              SizedBox(height: height * .04),
              Obx(
                () => CustomMaterialButton(
                  title: 'Login',
                  width: 300,
                  onPressed: controller.login,
                  isLoading: controller.isLoading,
                ),
              ),
              SizedBox(height: height * .2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  InkWell(
                    onTap: controller.onRegisterTapped,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .04),
            ],
          ),
        ),
      ),
    );
  }
}
