import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/SignInScreen/sign_in_screen.dart';
import 'package:service_call_management/screens/choose_items/choose_items.dart';
import 'package:service_call_management/screens/purchase_request/purchase_request.dart';
import 'package:service_call_management/screens/purchase_request_form/purchase_request_form.dart';
import 'package:service_call_management/screens/ticket_details/ticket_details.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            // Change this value to adjust scaling
            textScaleFactor: 1.0,
            //textScaler: const TextScaler.linear(1.5)
          ),
          child: child!,
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldColor,
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
             foregroundColor: MaterialStatePropertyAll(Colors.white)
          )
        ),
        appBarTheme:  AppBarTheme(
          backgroundColor: AppColors.blue2F6Color,
          centerTitle: false,
          foregroundColor: Colors.white,
          titleTextStyle: AppTextStyle.white16medium
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue2F6Color),
        useMaterial3: true,
      ),

      home: const ChooseItems(),
    );
  }
}


