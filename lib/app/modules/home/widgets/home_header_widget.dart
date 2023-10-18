import 'package:flutter/material.dart';
import 'package:trust_edge_task/app/data/models/user_model.dart';
import 'package:trust_edge_task/app/modules/home/widgets/home_header_item_widget.dart';

class HomeHeaderWidget extends StatelessWidget {
  final UserModel user;

  const HomeHeaderWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          HomeHeaderItemWidget(title: user.name, icon: Icons.person_3_outlined),
          const SizedBox(height: 20),
          HomeHeaderItemWidget(title: user.fullPhoneNumber, icon: Icons.phone_android),
          const SizedBox(height: 20),
          HomeHeaderItemWidget(title: user.email, icon: Icons.email_outlined),
        ],
      ),
    );
  }
}
