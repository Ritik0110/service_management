import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/HomeScreen/home_screen_controller.dart';
import 'package:service_call_management/utils/app_test_style.dart';

import '../../../utils/app_colors.dart';

class HomeFilterBottomSheet extends StatelessWidget {
   const HomeFilterBottomSheet({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    HomeControler homeController = Get.find();
    homeController.tempStatus.value = homeController.status.value;
    homeController.tempPriority.value = homeController.priority.value;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          color: AppColors.blueEFFColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColors.blueEFFColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("  Filter",
                    style: AppTextStyle.mediumTS.copyWith(
                      color: AppColors.blue2E6Color,
                      fontSize: 18,
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
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("  Triage",
                    style: AppTextStyle.mediumTS.copyWith(
                        color: AppColors.black191Color, fontSize: 16)),
                Obx(
                  () =>  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    spacing: 16,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            value: Status.all,
                            groupValue: homeController.tempStatus.value,
                            onChanged: (value) {
                              homeController.tempStatus.value = Status.all;
                            },
                          ),
                          Text("All",
                              style: AppTextStyle.mediumTS.copyWith(
                                  color: homeController.tempStatus.value == Status.all?AppColors.blue2F6Color:AppColors.grey848Color, fontSize: 18))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            value: Status.open,
                            groupValue: homeController.tempStatus.value,
                            onChanged: (value) {
                              homeController.tempStatus.value = Status.open;
                            },
                          ),
                          Text("Yes",
                              style: AppTextStyle.mediumTS.copyWith(
                                  color: homeController.tempStatus.value == Status.open?AppColors.blue2F6Color:AppColors.grey848Color, fontSize: 18))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            value: Status.close,
                            groupValue: homeController.tempStatus.value,
                            onChanged: (value) {
                              homeController.tempStatus.value = Status.close;
                            },
                          ),
                          Text("No",
                              style: AppTextStyle.mediumTS.copyWith(
                                  color: homeController.tempStatus.value == Status.close?AppColors.blue2F6Color:AppColors.grey848Color, fontSize: 18))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // const SizedBox(
          //   height: 2,
          // ),
          Container(
            width: Get.width,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green33AColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      homeController.status.value = homeController.tempStatus.value;
                      homeController.priority.value = homeController.tempPriority.value;
                      homeController.applyFilter();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Apply",
                            style: AppTextStyle.mediumTS.copyWith(
                                color: AppColors.whiteColor, fontSize: 16),
                          )
                        ],
                      ),
                    ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
