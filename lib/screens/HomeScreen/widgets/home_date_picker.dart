import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_test_style.dart';
import '../home_screen_controller.dart';
class HomeDatePicker extends StatelessWidget {
  const HomeDatePicker({super.key, required this.homeController});
   final HomeControler homeController;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: AppColors.blue2F6Color,
      child: EasyDateTimeLine(
        headerProps:  EasyHeaderProps(
          selectedDateFormat: SelectedDateFormat.fullDateDMonthAsStrY,
          selectedDateStyle: AppTextStyle.semiBoldTS.copyWith(
            fontSize: 16,
            color: AppColors.whiteColor,
          ),
          monthPickerType: MonthPickerType.switcher,
          monthStyle:AppTextStyle.semiBoldTS.copyWith(
            fontSize: 16,
            color: AppColors.whiteColor,
          ),
          showMonthPicker: true,
          showSelectedDate: true,
        ),
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          homeController.setSelectDate(selectedDate);
        },

        dayProps: EasyDayProps(
            dayStructure: DayStructure.dayNumDayStr,
            width: 60,
            height: 60,
            borderColor: Colors.transparent,
            activeBorderRadius: 8,
            activeDayDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            inactiveDayDecoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            activeDayNumStyle: AppTextStyle.semiBoldTS.copyWith(
              fontSize: 18,
              color: AppColors.blue2F6Color,
            ),
            activeDayStrStyle: AppTextStyle.regularTS.copyWith(
              color: AppColors.blue2F6Color,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            inactiveDayNumStyle: AppTextStyle.semiBoldTS.copyWith(
              fontSize: 16,
              color: AppColors.whiteColor,
            ),
            inactiveDayStrStyle: AppTextStyle.regularTS.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: AppColors.whiteColor,
            ),
            todayNumStyle:  AppTextStyle.semiBoldTS.copyWith(
              fontSize: 16,
              color: AppColors.whiteColor,
            ),
            todayStrStyle: AppTextStyle.regularTS.copyWith(
              fontWeight: FontWeight.w200,
              fontSize: 14,
              color: AppColors.whiteColor,
            )),
      ),
    );
  }
}
