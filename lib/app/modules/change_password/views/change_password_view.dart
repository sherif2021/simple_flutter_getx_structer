import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trust_edge_task/app/config/validators.dart';
import 'package:trust_edge_task/app/core/widgets/custom_material_button.dart';
import 'package:trust_edge_task/app/core/widgets/custom_text_form_field.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: height * .03),
                ValueBuilder<bool?>(
                  initialValue: true,
                  builder: (value, update) => CustomFormTextField(
                    hintText: 'Old Password',
                    controller: controller.oldPasswordController,
                    validator: Validators.passwordValidator,
                    secure: value!,
                    maxLines: 1,
                    width: 300,
                    textInputType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon:
                          Icon(value ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => update(!value),
                    ),
                  ),
                ),
                SizedBox(height: height * .03),
                ValueBuilder<bool?>(
                  initialValue: true,
                  builder: (value, update) => CustomFormTextField(
                    hintText: 'New Password',
                    controller: controller.passwordController,
                    validator: Validators.passwordValidator,
                    secure: value!,
                    maxLines: 1,
                    width: 300,
                    textInputType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon:
                          Icon(value ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => update(!value),
                    ),
                  ),
                ),
                SizedBox(height: height * .03),
                ValueBuilder<bool?>(
                  initialValue: true,
                  builder: (value, update) => CustomFormTextField(
                    hintText: 'Confirm New Password',
                    controller: controller.confirmPasswordController,
                    validator: Validators.passwordValidator,
                    secure: value!,
                    maxLines: 1,
                    width: 300,
                    textInputType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon:
                          Icon(value ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => update(!value),
                    ),
                  ),
                ),
                SizedBox(height: height * .04),
                Obx(
                  () => CustomMaterialButton(
                    title: 'Change Password',
                    width: 300,
                    onPressed: controller.changePassword,
                    isLoading: controller.isLoading,
                  ),
                ),
                SizedBox(height: height * .04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
