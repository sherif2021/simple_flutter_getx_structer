import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trust_edge_task/app/config/utils/app_assets.dart';
import 'package:trust_edge_task/app/config/utils/app_colors.dart';
import 'package:trust_edge_task/app/config/utils/app_text_styles.dart';
import 'package:trust_edge_task/app/config/validators.dart';
import 'package:trust_edge_task/app/core/widgets/custom_material_button.dart';
import 'package:trust_edge_task/app/core/widgets/custom_text_form_field.dart';
import 'package:trust_edge_task/app/modules/register/controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

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
                'Register',
                style: AppTextStyles.titleTextStyle,
              ),
              SizedBox(height: height * .05),
              CustomFormTextField(
                hintText: 'Full Name',
                controller: controller.nameController,
                validator: Validators.nameValidator,
                maxLines: 1,
                textInputType: TextInputType.name,
                width: 300,
              ),
              SizedBox(height: height * .03),
              CustomFormTextField(
                hintText: '55994435',
                controller: controller.phoneController,
                validator: (v) =>
                    Validators.phoneValidator(controller.countryCode, v),
                maxLines: 1,
                textInputType: TextInputType.phone,
                width: 300,
                textAlign: TextAlign.start,
                prefixIcon: CountryCodePicker(
                  onChanged: (value) =>
                      controller.countryCode = value.dialCode!,
                  onInit: (value) =>
                      controller.countryCode = value?.dialCode! ?? '+20',
                  initialSelection: Get.locale?.countryCode ?? 'PS',
                  favorite: const ['PS', 'EG'],
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: false,
                  hideMainText: true,
                  alignLeft: false,
                ),
              ),
              SizedBox(height: height * .03),
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
                  suffixIcon: IconButton(
                    icon: Icon(value ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => update(!value),
                  ),
                ),
              ),
              SizedBox(height: height * .03),
              ValueBuilder<bool?>(
                initialValue: true,
                builder: (value, update) => CustomFormTextField(
                  hintText: 'Confirm Password',
                  controller: controller.confirmPasswordController,
                  validator: Validators.passwordValidator,
                  secure: value!,
                  maxLines: 1,
                  width: 300,
                  textInputType: TextInputType.visiblePassword,
                  onSubmit: (v) => controller.register(),
                  suffixIcon: IconButton(
                    icon: Icon(value ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => update(!value),
                  ),
                ),
              ),
              SizedBox(height: height * .04),
              Obx(
                () => CustomMaterialButton(
                  title: 'Register',
                  width: 300,
                  onPressed: controller.register,
                  isLoading: controller.isLoading,
                ),
              ),
              SizedBox(height: height * .04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("already have an account? "),
                  InkWell(
                    onTap: controller.onLoginTapped,
                    child: const Text(
                      'Login',
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
