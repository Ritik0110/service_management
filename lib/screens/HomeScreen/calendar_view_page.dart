import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calendar_view_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_test_style.dart';
import 'widgets/ticket_card.dart';

class CalendarViewPage extends StatelessWidget {
  CalendarViewPage({super.key});

  CalenderController controller = Get.put(CalenderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar View Page'),
        ),
        body: Column(
          children: [
            GetBuilder(builder: (CalenderController controller) {
              return Container(
                color: Colors.white,
                child: TableCalendar(
                    calendarBuilders: CalendarBuilders(
                      outsideBuilder: (context, date, events) {
                        return Container();
                      },
                      singleMarkerBuilder: (context, date, event) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppColors.blue2E6Color,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 10,
                          height: 5,
                        );
                      },
                      selectedBuilder: (context, date, events) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: AppTextStyle.semiBoldTS
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    daysOfWeekHeight: 35,
                    rowHeight: 40,
                    currentDay: controller.day.value,
                    eventLoader: controller.setDates,
                    calendarStyle: const CalendarStyle(
                      isTodayHighlighted: false,
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    onDaySelected: controller.onDaySelect,
                    selectedDayPredicate: (day) {
                      return isSameDay(controller.day.value, day);
                    },
                    onPageChanged: controller.onPageChange,
                    focusedDay: controller.day.value,
                    firstDay: DateTime(DateTime.now().year-2),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    lastDay: DateTime(DateTime.now().year+2)),
              );
            }),
            Expanded(
              child: Obx(
                () => Container(
                  color: AppColors.blueEFFColor,
                  child: controller.ticketList.isEmpty
                      ? Center(
                          child: Text(
                            "No Data Found.",
                            style: AppTextStyle.semiBoldTS
                                .copyWith(color: AppColors.grey848Color),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: controller.ticketList.length,
                          itemBuilder: (context, index) {
                            return TicketCard(
                              ticketId:
                                  controller.ticketList[index].serviceCallNo ??
                                      'N/A',
                              ticketSubStatus:
                                  controller.ticketList[index].subStatus ??
                                      "N/A",
                              ticketTitle:
                                  controller.ticketList[index].subject ?? "N/A",
                              ticketTime: double.parse(
                                      controller.ticketList[index].duration ??
                                          "0.0")
                                  .toStringAsFixed(2),
                              model:
                                  controller.ticketList[index].model ?? "N/A",
                              manuSN:
                                  controller.ticketList[index].manuSN ?? "N/A",
                              ticketLocation:
                                  controller.ticketList[index].address ?? 'N/A',
                              ticketStatus:
                                  controller.ticketList[index].callStatus ??
                                      "N/A",
                              ticketPriority:
                                  controller.ticketList[index].priority ??
                                      "N/A",
                              contactNumber:
                                  controller.ticketList[index].contactMobNo ??
                                      "",
                              contactPerson:
                                  controller.ticketList[index].contactPerson ??
                                      "N/A",
                              customerName:
                                  controller.ticketList[index].customerName ??
                                      "N/A",
                              endDate:
                                  controller.ticketList[index].endDate ?? "N/A",
                              startDate:
                                  controller.ticketList[index].generateDate ??
                                      "N/A",
                              triage:
                                  controller.ticketList[index].triage ?? "N/A",
                              duration: double.parse(
                                      controller.ticketList[index].duration ??
                                          "0.0")
                                  .toStringAsFixed(2),
                              remark:
                                  controller.ticketList[index].remarks ?? "N/A",
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ));
  }
}
