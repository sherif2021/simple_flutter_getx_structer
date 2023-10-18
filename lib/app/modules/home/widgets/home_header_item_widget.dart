import 'package:flutter/cupertino.dart';
import 'package:trust_edge_task/app/config/utils/app_colors.dart';

class HomeHeaderItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const HomeHeaderItemWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
