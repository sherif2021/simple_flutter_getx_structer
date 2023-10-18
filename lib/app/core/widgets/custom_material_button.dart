import 'package:flutter/material.dart';
import 'package:trust_edge_task/app/config/utils/app_colors.dart';

class CustomMaterialButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final BorderRadius? borderRadius;
  final double? width;

  const CustomMaterialButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width ?? double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      onPressed: isLoading ? () {} : onPressed,
      color: AppColors.primaryColor,
      child: isLoading
          ? const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
