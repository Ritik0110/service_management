import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isRememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }
}
