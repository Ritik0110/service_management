import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/HomeScreen/widgets/home_bottom_sheet.dart';
import 'package:service_call_management/utils/app_test_style.dart';

import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: const Drawer(),
      appBar: AppBar(

        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_outlined,
                size: 30,
              )),
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                  )),
              Positioned(
                top: 2,
                right: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  radius: 10,
                  child: const Center(
                      child: FittedBox(
                          child: Text(
                    '5',
                  ))),
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: AppColors.blue2F6Color,
            child: EasyDateTimeLine(
              headerProps:  EasyHeaderProps(
                selectedDateFormat: SelectedDateFormat.fullDateDMonthAsStrY,
                selectedDateStyle: AppTextStyle.semiBoldTS.copyWith(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                ),
                monthPickerType: MonthPickerType.switcher,
                monthStyle:AppTextStyle.semiBoldTS.copyWith(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                ),
                showMonthPicker: true,
                showSelectedDate: true,
              ),
              initialDate: DateTime.now(),
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
                    fontSize: 12,
                    color: AppColors.blue2F6Color,
                  ),
                  activeDayStrStyle: AppTextStyle.regularTS.copyWith(
                    color: AppColors.blue2F6Color,
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                  ),
                  inactiveDayNumStyle: AppTextStyle.semiBoldTS.copyWith(
                    fontSize: 11,
                    color: AppColors.whiteColor,
                  ),
                  inactiveDayStrStyle: AppTextStyle.regularTS.copyWith(
                  fontSize: 10,
                    fontWeight: FontWeight.w200,
                color: AppColors.whiteColor,
              ),
                  todayNumStyle:  AppTextStyle.semiBoldTS.copyWith(
                fontSize: 11,
                color: AppColors.whiteColor,
              ),
                  todayStrStyle: AppTextStyle.regularTS.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 10,
                    color: AppColors.whiteColor,
                  )),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width :16,


                ),
                Text(
                  "Today Ticket ",
                    style: AppTextStyle.mediumTS.copyWith(fontSize: 12,color: AppColors.grey848Color)),
                Text(
                    "(10)",
                    style: AppTextStyle.mediumTS.copyWith(color: AppColors.black333Color,fontSize: 12)),
                const Spacer(),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return HomeFilterBottomSheet();
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: AppColors.blueEFFColor,
                    child: Row(
                      children: [
                        Text("Filter",style: AppTextStyle.mediumTS.copyWith(color: AppColors.blue2E6Color,fontSize: 12)),
                        const Icon(
                          Icons.filter_alt_outlined,
                          color: Color(
                            0xFF2f67de,
                          ),
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.green47CColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 6),
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "#405514",
                                  style: AppTextStyle.semiBoldTS.copyWith(
                                    color: AppColors.grey646Color,
                                    fontSize: 12
                                  )
                                ),
                                Text(
                                  "Computer Not Working",
                                  style: AppTextStyle.semiBoldTS.copyWith(
                                      color: AppColors.black191Color,
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            CircleAvatar(
                                backgroundColor: Colors.grey.shade100,
                                child: const Icon(
                                  Icons.call,
                                  color:AppColors.green34CColor,
                                ))
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              "Time : ",
                              style: AppTextStyle.regularTS.copyWith(
                                fontSize: 12,
                                color: AppColors.grey848Color,
                              ),
                            ),
                            Text(
                              "01:30 PM",
                              style: AppTextStyle.semiBoldTS.copyWith(
                                  color: AppColors.black323Color,
                                  fontSize: 12
                              ),),
                            const Spacer(),
                            Text(
                              "Priority : ",
                              style: AppTextStyle.regularTS.copyWith(
                                fontSize: 12,
                                color: AppColors.grey848Color,
                              ),
                            ),
                            Text(
                              "High",
                              style: AppTextStyle.semiBoldTS.copyWith(
                                  fontSize: 12,
                                  color: AppColors.purple9C5Color),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            Expanded(
                                child: Text(
                              "Gitschiner Str., Berlin Germany",
                              style: AppTextStyle.mediumTS.copyWith(
                                fontSize: 10,
                                color: AppColors.black191Color
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


