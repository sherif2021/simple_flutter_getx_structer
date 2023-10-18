import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trust_edge_task/app/config/utils/app_strings.dart';
import 'package:trust_edge_task/app/config/utils/app_theme.dart';

import 'app/config/app_binding.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: AppStrings.appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      theme: appTheme(),
    ),
  );
}
