// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_test_style.dart';

class CommonMaterialButton extends StatelessWidget {
  CommonMaterialButton(
      {required this.buttonText, required this.onTap,this.width, super.key});
  String buttonText;
  double? width;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: AppColors.green33AColor,
      minWidth: width ?? double.maxFinite,
      height: 50,
      onPressed: onTap,
      child: Text(buttonText, style: AppTextStyle.white16medium),
    );
  }
}
