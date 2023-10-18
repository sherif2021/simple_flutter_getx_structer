import 'package:flutter/material.dart';
import 'package:trust_edge_task/app/config/utils/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final BorderRadius? borderRadius;
  final double? width;

  const CustomOutlinedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          //minWidth: width ?? double.infinity,
          side: const BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
          ),
        ),
        onPressed: isLoading ? () {} : onPressed,
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
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
      ),
    );
  }
}
