import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trust_edge_task/app/config/validators.dart';
import 'package:trust_edge_task/app/core/widgets/custom_material_button.dart';
import 'package:trust_edge_task/app/core/widgets/custom_text_form_field.dart';

import '../controllers/update_info_controller.dart';

class UpdateInfoView extends GetView<UpdateInfoController> {
  const UpdateInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: height * .03),
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
                    initialSelection: controller.countryCode,
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
                SizedBox(height: height * .04),
                Obx(
                  () => CustomMaterialButton(
                    title: 'Save',
                    width: 300,
                    onPressed: controller.save,
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
