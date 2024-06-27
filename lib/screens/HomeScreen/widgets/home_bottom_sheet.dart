import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/HomeScreen/home_screen_controller.dart';
import 'package:service_call_management/utils/app_test_style.dart';

import '../../../utils/app_colors.dart';

class HomeFilterBottomSheet extends StatefulWidget {
  const HomeFilterBottomSheet({
    super.key,
  });

  @override
  State<HomeFilterBottomSheet> createState() => _HomeFilterBottomSheetState();
}

class _HomeFilterBottomSheetState extends State<HomeFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    homeController.tempStatus.value = homeController.status.value;
    homeController.tempTriage.value = homeController.triage.value;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          color: AppColors.blueEFFColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: SingleChildScrollView(
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
                  Text("  Status",
                      style: AppTextStyle.mediumTS.copyWith(
                          color: AppColors.black191Color, fontSize: 16)),
                  Obx(
                    () => Wrap(
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
                                    color: homeController.tempStatus.value ==
                                            Status.all
                                        ? AppColors.blue2F6Color
                                        : AppColors.grey848Color,
                                    fontSize: 18))
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
                            Text("Open",
                                style: AppTextStyle.mediumTS.copyWith(
                                    color: homeController.tempStatus.value ==
                                            Status.open
                                        ? AppColors.blue2F6Color
                                        : AppColors.grey848Color,
                                    fontSize: 18))
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
                            Text("Close",
                                style: AppTextStyle.mediumTS.copyWith(
                                    color: homeController.tempStatus.value ==
                                            Status.close
                                        ? AppColors.blue2F6Color
                                        : AppColors.grey848Color,
                                    fontSize: 18))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text("  SubStatus",
                      style: AppTextStyle.mediumTS.copyWith(
                          color: AppColors.black191Color, fontSize: 16)),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    spacing: 16,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      ListView.builder(
                          itemCount: homeController.subStatusList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() => Checkbox(
                                    value: homeController.subStatusMap[
                                        homeController.subStatusList[index]],
                                    onChanged: (value) {
                                      homeController.subStatusMap[homeController
                                          .subStatusList[index]] = value!;
                                      homeController.filterSubList.contains(
                                              homeController
                                                  .subStatusList[index])
                                          ? homeController.filterSubList.remove(
                                              homeController
                                                  .subStatusList[index])
                                          : homeController.filterSubList.add(
                                              homeController
                                                  .subStatusList[index]);
                                    })),
                                Text(homeController.subStatusList[index] ?? "",
                                    style: AppTextStyle.mediumTS.copyWith(
                                        color: AppColors.grey848Color,
                                        fontSize: 18))
                              ],
                            );
                          }),
                    ],
                  ),
                  Text("  Triage",
                      style: AppTextStyle.mediumTS.copyWith(
                          color: AppColors.black191Color, fontSize: 16)),
                  Obx(
                    () => Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      spacing: 16,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio(
                              value: Triage.all,
                              groupValue: homeController.tempTriage.value,
                              onChanged: (value) {
                                homeController.tempTriage.value = Triage.all;
                              },
                            ),
                            Text("All",
                                style: AppTextStyle.mediumTS.copyWith(
                                    color: homeController.triage.value ==
                                            Triage.all
                                        ? AppColors.blue2F6Color
                                        : AppColors.grey848Color,
                                    fontSize: 18))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio(
                              value: Triage.yes,
                              groupValue: homeController.tempTriage.value,
                              onChanged: (value) {
                                homeController.tempTriage.value = Triage.yes;
                              },
                            ),
                            Text("Yes",
                                style: AppTextStyle.mediumTS.copyWith(
                                    color: homeController.tempTriage.value ==
                                            Triage.yes
                                        ? AppColors.blue2F6Color
                                        : AppColors.grey848Color,
                                    fontSize: 18))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio(
                              value: Triage.no,
                              groupValue: homeController.tempTriage.value,
                              onChanged: (value) {
                                homeController.tempTriage.value = Triage.no;
                              },
                            ),
                            Text("No",
                                style: AppTextStyle.mediumTS.copyWith(
                                    color: homeController.tempTriage.value ==
                                            Triage.no
                                        ? AppColors.blue2F6Color
                                        : AppColors.grey848Color,
                                    fontSize: 18))
                          ],
                        ),
                      ],
                    ),
                  ),
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
                      homeController.status.value =
                          homeController.tempStatus.value;
                      //homeController.priority.value = homeController.tempPriority.value;
                      homeController.triage.value =
                          homeController.tempTriage.value;
                      homeController.applyFilter1();
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
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  commonBox(bool value, String name) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: (value) {}),
        Text(name,
            style: AppTextStyle.mediumTS
                .copyWith(color: AppColors.grey848Color, fontSize: 18))
      ],
    );
  }
}
