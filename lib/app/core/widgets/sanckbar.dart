import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSackBar({
  required String message,
  String? title,
}) {
  Get.snackbar(
    title ?? 'Error',
    message,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    duration: const Duration(seconds: 3),
  );
}

void showSuccessSackBar({
  required String message,
  String? title,
}) {
  Get.snackbar(
    title ?? 'Success',
    message,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    duration: const Duration(seconds: 3),
  );
}
