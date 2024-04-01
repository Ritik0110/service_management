import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:service_call_management/utils/app_test_style.dart';

import '../../../utils/app_colors.dart';
class HomeFilterBottomSheet extends StatelessWidget {
  const HomeFilterBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          color: AppColors.blueEFFColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColors.blueEFFColor,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                 Text("Filter",style: AppTextStyle.mediumTS.copyWith(
                  color: AppColors.blue2E6Color,
                   fontSize: 14,
                )),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.blue2E6Color,
                    ))
              ],
            ),
          ),
          Container(
            width: Get.width,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Status",style: AppTextStyle.mediumTS.copyWith(
                  color: AppColors.black191Color,
                  fontSize: 12
                )),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  spacing: 16,
                 runAlignment: WrapAlignment.spaceBetween,

                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: true,
                          groupValue: true,
                          onChanged: (value) {},
                        ),
                         Text("All",style: AppTextStyle.mediumTS.copyWith(
                          color: AppColors.blue2F6Color,
                          fontSize: 14
                        ))
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: true,
                          groupValue: true,
                          onChanged: (value) {},
                        ),
                         Text("Open",style: AppTextStyle.mediumTS.copyWith(
                            color: AppColors.blue2F6Color,
                            fontSize: 14
                        ))
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: true,
                          groupValue: true,
                          onChanged: (value) {},
                        ),
                         Text("Close",style: AppTextStyle.mediumTS.copyWith(
                            color: AppColors.blue2F6Color,
                            fontSize: 14
                        ))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Container(
            width: Get.width,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Priority",style: AppTextStyle.mediumTS.copyWith(
                    color: AppColors.black191Color,
                    fontSize: 12
                )),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 16.0, // Adjust spacing as needed
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: true,
                          groupValue: true,
                          onChanged: (value) {},
                        ),
                         Text("All",style: AppTextStyle.mediumTS.copyWith(
                            color: AppColors.blue2F6Color,
                            fontSize: 14
                        ))
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: true,
                          groupValue: true,
                          onChanged: (value) {},
                        ),
                        Text("High",style: AppTextStyle.mediumTS.copyWith(
                            color: AppColors.blue2F6Color,
                            fontSize: 14
                        ))
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: true,
                          groupValue: true,
                          onChanged: (value) {},
                        ),
                        Text("Medium",style: AppTextStyle.mediumTS.copyWith(
                            color: AppColors.blue2F6Color,
                            fontSize: 14
                        ))
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: true,
                          groupValue: true,
                          onChanged: (value) {},
                        ),
                        Text("Low",style: AppTextStyle.mediumTS.copyWith(
                            color: AppColors.blue2F6Color,
                            fontSize: 14
                        ))
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green33AColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),),

                    ),

                    onPressed: () {

                    }, child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Apply",style: AppTextStyle.mediumTS.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 16
                      ),)
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}