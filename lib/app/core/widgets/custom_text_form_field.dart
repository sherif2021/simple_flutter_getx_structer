import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? borderColor;
  final TextInputType? textInputType;
  final String? hintText;
  final String? initValue;
  final bool enable;
  final double? height;
  final double width;
  final bool secure;
  final ValueChanged<String>? onChange;
  final int? minLines;
  final int maxLines;
  final Widget? icon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final ValueChanged<String?>? onSubmit;
  final FormFieldValidator<String>? validator;

  final TextAlign? textAlign;

  const CustomFormTextField({
    super.key,
    this.controller,
    this.textInputType,
    this.hintText,
    this.borderColor,
    this.initValue,
    this.enable = true,
    this.height,
    this.width = double.infinity,
    this.secure = false,
    this.onChange,
    this.maxLines = 1,
    this.minLines,
    this.onSubmit,
    this.icon,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.center,
        onTapOutside: (v) => FocusScope.of(context).unfocus(),
        maxLines: maxLines,
        minLines: minLines,
        onChanged: onChange,
        obscureText: secure,
        initialValue: initValue,
        validator: validator,
        enabled: enable,
        keyboardType: textInputType,
        onFieldSubmitted: onSubmit,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          icon: icon,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
