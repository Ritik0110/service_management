import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/SignInScreen/sign_in_screen.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_preferences.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/app_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/employee_model.dart';
import 'screens/HomeScreen/home_screen.dart';


Future<void> main() async {
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  AppVariables.isLoggedIn = prefs.getBool(AppPreferences.isLoggedIn) ?? false;
  if(AppVariables.isLoggedIn){
     AppVariables.employeeModel = EmployeeModel.fromJson(json.decode(prefs.getString(AppPreferences.storedEmpData) ?? '{}'));
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            // Change this value to adjust scaling
            textScaler: const TextScaler.linear(1.0),
            //textScaler: const TextScaler.linear(1.5)
          ),
          child: child!,
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Montserrat",
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
      home: AppVariables.isLoggedIn? const HomeScreen():const SignInScreen(),
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

