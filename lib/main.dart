import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/SignInScreen/sign_in_screen.dart';
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
            textScaleFactor: 1.5,
            //textScaler: const TextScaler.linear(1.5)
          ),
          child: child!,
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
             foregroundColor: MaterialStatePropertyAll(Colors.white)
          )
        ),
        appBarTheme:    AppBarTheme(
          backgroundColor:AppColors.blue2F6Color,
          centerTitle: false,
          foregroundColor: Colors.white,
          titleTextStyle: AppTextStyle.mediumTS.copyWith(
            color: AppColors.whiteColor,
            fontSize: 16,
          )
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue2F6Color),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}


