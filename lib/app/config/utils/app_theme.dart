import 'package:flutter/material.dart';
import 'package:trust_edge_task/app/config/constants.dart';
import 'package:trust_edge_task/app/config/utils/app_colors.dart';

ThemeData appTheme() => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      useMaterial3: true,
      fontFamily: Constants.fontFamily,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          fontFamily: Constants.fontFamily,
        ),
      ),
    );
