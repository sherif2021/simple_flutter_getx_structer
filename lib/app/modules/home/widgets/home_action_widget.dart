import 'package:flutter/material.dart';
import 'package:trust_edge_task/app/config/utils/app_colors.dart';

class HomeActionWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const HomeActionWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: .5,
          child: ListTile(
            onTap: onPressed,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
