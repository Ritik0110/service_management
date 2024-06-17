import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

import '../screens/HomeScreen/home_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_test_style.dart';
import 'common_button.dart';

class CommonPopUp {
  CommonPopUp._();

  static Future showPopup(bool result, String showMsg) async {
    Get.dialog(
      PopScope(
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  15.sizedBoxHeight,
                  Icon(
                    result ? Icons.check_circle_outline : Icons.error_outline,
                    color: result ? AppColors.green33AColor : Colors.red,
                    size: 80,
                  ),
                  Text(
                    showMsg,
                    style: AppTextStyle.black191medium16,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  20.sizedBoxHeight,
                  result
                      ? CommonMaterialButton(
                          spacing: false,
                          buttonText: "Back to Home",
                          onTap: () {
                            Get.offAll(const HomeScreen());
                          },
                          width: 200,
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            minimumSize: const Size(double.maxFinite, 50),
                          ),
                          onPressed: () {
                            Get.back();
                          }, child: Text("Close",style: AppTextStyle.white14semiBold,)),
                  10.sizedBoxHeight
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: !result,
    );
  }
}
