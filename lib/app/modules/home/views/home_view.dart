import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trust_edge_task/app/modules/home/widgets/home_action_widget.dart';
import 'package:trust_edge_task/app/modules/home/widgets/home_header_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => HomeHeaderWidget(user: controller.user)),
            const SizedBox(height: 30),
            HomeActionWidget(
              title: 'Update Information',
              onPressed: controller.onUpdateInfoPressed,
            ),
            HomeActionWidget(
              title: 'Change Password',
              onPressed: controller.onChangePasswordPressed,
            ),
            HomeActionWidget(
              title: 'Delete Account',
              onPressed: controller.showDeleteAccountDialog,
            ),
            HomeActionWidget(
              title: 'Logout',
              onPressed: controller.showLogoutDialog,
            ),
          ],
        ),
      ),
    );
  }
}
