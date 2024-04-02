import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/SignInScreen/sign_in_screen.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';


void main() {
  HttpOverrides.global = MyHttpOverrides();
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        scaffoldBackgroundColor: AppColors.scaffoldColor,
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
             foregroundColor: MaterialStatePropertyAll(Colors.white)
          )
        ),
        appBarTheme:  AppBarTheme(
          shadowColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.blue2F6Color,
          centerTitle: false,
          foregroundColor: Colors.white,
          titleTextStyle: AppTextStyle.white16medium
        ),
        radioTheme: RadioThemeData(

          fillColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? AppColors.blue2F6Color : Colors.grey),
          visualDensity: VisualDensity.standard,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue2F6Color),
        useMaterial3: true,
      ),

      home: const SignInScreen(),
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
