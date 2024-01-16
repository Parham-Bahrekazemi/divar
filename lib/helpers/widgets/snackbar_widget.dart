import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successMessage(String message) {
  Get.snackbar(
    'موفق',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    colorText: Colors.white,
  );
}

void errorMessage(String message) {
  Get.snackbar(
    'نا موفق',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    colorText: Colors.white,
  );
}
