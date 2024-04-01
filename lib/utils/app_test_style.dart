import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle{
  AppTextStyle._();

  static TextStyle regularTS = const TextStyle(
    fontFamily: "Montserrat",
  );

  static TextStyle mediumTS = const TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w300,
  );

  static TextStyle semiBoldTS = const TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w600,
  );

  static TextStyle boldTS = const TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w700,
  );

  // grey84 14
  static TextStyle grey84regular14 = regularTS.copyWith(
    color: AppColors.grey848Color,
    fontSize: 14,
  );
  static TextStyle grey84regular16 = regularTS.copyWith(
    color: AppColors.grey848Color,
    fontSize: 16,
  );
  static TextStyle black323regular16 = regularTS.copyWith(
    color: AppColors.black323Color,
    fontSize: 16,
  );
  static TextStyle black323regular14 = regularTS.copyWith(
    color: AppColors.black323Color,
    fontSize: 14,
  );
  static TextStyle yellowFF9regular16 = regularTS.copyWith(
    color: AppColors.yellowFF9Color,
    fontSize: 16,
  );



  static TextStyle black323medium14 = mediumTS.copyWith(
    color: AppColors.black323Color,
    fontSize: 14,
  );
  static TextStyle grey7A7medium14 = mediumTS.copyWith(
    color: AppColors.grey7A7Color,
    fontSize: 14,
  );
  static TextStyle black191medium16 = mediumTS.copyWith(
    color: AppColors.black191Color,
    fontSize: 16,
  );
  static TextStyle white16medium = mediumTS.copyWith(
    color: AppColors.whiteColor,
    fontSize: 16,
  );
  static TextStyle grey7A7medium16 = mediumTS.copyWith(
    color: AppColors.grey7A7Color,
    fontSize: 16,
  );
  static TextStyle blue24medium16 = mediumTS.copyWith(
    color: AppColors.blue24Color,
    fontSize: 16,
  );
  static TextStyle pinkC42medium16 = mediumTS.copyWith(
    color: AppColors.pinkC42Color,
    fontSize: 16,
  );



  static TextStyle black323semi14 = semiBoldTS.copyWith(
    color: AppColors.black323Color,
    fontSize: 14,
  );
  static TextStyle grey646semi16 = semiBoldTS.copyWith(
    color: AppColors.grey646Color,
    fontSize: 16,
  );
  static TextStyle green47cSemi16 = semiBoldTS.copyWith(
    color: AppColors.green47CColor,
    fontSize: 16,
  );
  static TextStyle black323semi16 = semiBoldTS.copyWith(
    color: AppColors.black323Color,
    fontSize: 16,
  );
  static TextStyle yellowFF9Semi16 = semiBoldTS.copyWith(
    color: AppColors.yellowFF9Color,
    fontSize: 16,
  );
  static TextStyle blue2f6Semi16 = semiBoldTS.copyWith(
    color: AppColors.blue2F6Color,
    fontSize: 16,
  );
  static TextStyle redFF5Semi16 = semiBoldTS.copyWith(
    color: AppColors.redFF5Color,
    fontSize: 16,
  );
}