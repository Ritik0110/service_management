import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:service_call_management/utils/api_helper.dart';
import 'package:service_call_management/utils/app_preferences.dart';
import 'package:service_call_management/utils/app_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen/home_screen.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isRememberMe = false.obs;
  final errorMessage = "".obs;
  @override
  void onReady() {
    // TODO: implement onReady
    loadStoredData();
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> loadStoredData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    errorMessage.value = "";
    isRememberMe.value =
        preferences.getBool(AppPreferences.isRememberMe) ?? false;
    if (isRememberMe.value) {
      emailController.text =
          preferences.getString(AppPreferences.storedEmpId) ?? '';
      passwordController.text =
          preferences.getString(AppPreferences.storedEmpPass) ?? '';
    } else {
      emailController.text = '';
      passwordController.text = '';
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  Future<void> signIn() async {
    Get.dialog(
      const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      barrierDismissible: false,
    );
    String loginResult =
        await ApiHelper.SignIn(emailController.text, passwordController.text);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    if (loginResult == "1") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(AppPreferences.storedEmpData,
          jsonEncode(AppVariables.employeeModel.toJson()));
      prefs.setBool(AppPreferences.isLoggedIn, true);
      prefs.setBool(AppPreferences.isRememberMe, isRememberMe.value);
      if (isRememberMe.value) {
        prefs.setString(AppPreferences.storedEmpId, emailController.text);
        prefs.setString(AppPreferences.storedEmpPass, passwordController.text);
      } else {
        await prefs.remove(AppPreferences.storedEmpId);
        await prefs.remove(AppPreferences.storedEmpPass);
      }
      Get.offAll(const HomeScreen());
    } else {
      errorMessage.value = loginResult;
    }
  }
}
