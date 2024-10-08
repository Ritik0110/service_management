// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_test_style.dart';

class CommonMaterialButton extends StatelessWidget {
  CommonMaterialButton(
      {required this.buttonText,
      this.enable = true,
      required this.onTap,
      this.width,
      this.spacing = true,
      super.key});
  String buttonText;
  double? width;
  bool enable;
  bool spacing;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      padding: spacing?const EdgeInsets.symmetric(horizontal: 16, vertical: 12):EdgeInsets.zero,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        disabledColor: AppColors.grey848Color,
        color: AppColors.green33AColor,
        minWidth: width ?? double.maxFinite,
        height: 50,
        onPressed: enable ? onTap : null,
        child: Text(buttonText, style: AppTextStyle.white16medium),
      ),
    );
  }
}
