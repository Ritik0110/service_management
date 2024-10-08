import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_test_style.dart';
import '../home_screen_controller.dart';

class HomeDatePicker extends StatelessWidget {
  const HomeDatePicker({super.key, required this.homeController});
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    String calenderKey = "calenderKey";
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: AppColors.blue2F6Color,
      child: Stack(
        children: [
          Obx(
            () {
              return EasyDateTimeLine(
                key: Key(calenderKey),
                headerProps: EasyHeaderProps(
                  dateFormatter: const FullDateDMonthAsStrYFormatter(),
                  selectedDateStyle: AppTextStyle.semiBoldTS.copyWith(
                    fontSize: 16,
                    color: AppColors.whiteColor,
                  ),
                  monthPickerType: MonthPickerType.switcher,
                  monthStyle: AppTextStyle.semiBoldTS.copyWith(
                    fontSize: 16,
                    color: AppColors.whiteColor,
                  ),
                  showMonthPicker: true,
                  showSelectedDate: true,
                ),
                initialDate: homeController.selectedDate.value,
                onDateChange: (selectedDate) {
                  homeController.setSelectDate(selectedDate);
                },
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayNumDayStr,
                  width: 60,
                  height: 60,
                  borderColor: Colors.transparent,



                  activeDayStyle: DayStyle(
                    borderRadius: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    dayStrStyle: AppTextStyle.regularTS.copyWith(
                      color: AppColors.blue2F6Color,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    dayNumStyle: AppTextStyle.semiBoldTS.copyWith(
                      fontSize: 18,
                      color: AppColors.blue2F6Color,
                    ),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    dayNumStyle: AppTextStyle.semiBoldTS.copyWith(
                      fontSize: 16,
                      color: AppColors.whiteColor,
                    ),
                    dayStrStyle: AppTextStyle.regularTS.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  todayStyle: DayStyle(
                    dayNumStyle: AppTextStyle.semiBoldTS.copyWith(
                      fontSize: 16,
                      color: AppColors.whiteColor,
                    ),
                    dayStrStyle: AppTextStyle.regularTS.copyWith(
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 5,
            top: 10,
            child: InkWell(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: homeController.selectedDate.value,
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)))
                    .then((value) {
                  if (value != null) {
                    calenderKey = value.toString();
                    homeController.setSelectDate(value);
                  }
                });
              },
              child: const SizedBox(
                width: 130,
                height: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
