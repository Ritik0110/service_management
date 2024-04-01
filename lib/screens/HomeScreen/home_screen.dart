import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/HomeScreen/home_screen_controller.dart';
import 'package:service_call_management/screens/HomeScreen/widgets/home_bottom_sheet.dart';
import 'package:service_call_management/screens/HomeScreen/widgets/home_date_picker.dart';
import 'package:service_call_management/screens/HomeScreen/widgets/ticket_card.dart';
import 'package:service_call_management/screens/SignInScreen/sign_in_screen.dart';
import 'package:service_call_management/utils/app_test_style.dart';

import '../../Models/TicketsModel.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControler controller = Get.put(HomeControler());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                controller.searchText.value = '';
                Get.dialog(useSafeArea: false,Dialog.fullscreen(
                  child: Scaffold(

                    appBar:
                      AppBar(
                        title: const Text('Search Ticket'),
                        leading: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                     body:   SafeArea(
                       child: Column(
                         children: [
                            Padding(
                             padding: EdgeInsets.all(16.0),
                             child: CustomTextFormField(title: 'Search Ticket', isRequired: false,onChanged: (value){
                               controller.searchText.value = value;
                             },
                           )),
                           Expanded(
                             child: Obx(
                               () {
                                List<Data> searchResult =  controller.ticketList.where((element) => element.title?.toLowerCase()?.contains(controller.searchText.value.toLowerCase())??false).toList();
                                 return ListView.builder(
                                 padding: const EdgeInsets.all(16),
                                  shrinkWrap: true,
                                 scrollDirection: Axis.vertical,

                                 itemCount: searchResult.length,
                                 itemBuilder: (context, index) {
                                   return  TicketCard(ticketId:searchResult[index].id??"", ticketTitle: searchResult[index].title??"", ticketTime: searchResult[index].time??"", ticketPriority: searchResult[index].priority??"", ticketLocation: searchResult[index].location??"", ticketStatus: searchResult[index].status??"",);
                                 },);}
                             ),
                           ),
                         ],
                       ),
                     ),



                  )
                ));
              },
              icon: Image.asset(
                AppAssets.searchIcon,
                height: 20,
              )),
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    AppAssets.notificationIcon,
                    height: 25,
                  )),
              // Positioned(
              //   top: 2,
              //   right: 2,
              //   child: CircleAvatar(
              //     backgroundColor: Colors.red.shade700,
              //     foregroundColor: Colors.white,
              //     radius: 10,
              //     child: const Center(
              //         child: FittedBox(
              //             child: Text(
              //       '5',
              //     ))),
              //   ),
              // ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          HomeDatePicker(homeController: controller),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text("Today Ticket ",
                    style: AppTextStyle.mediumTS
                        .copyWith(fontSize: 16, color: AppColors.grey848Color)),
                Expanded(
                  child: Obx(
                    () {
                      int count = controller.ticketsModel.data?.where((element) {
                        if (element.date == null) {
                          if (kDebugMode) {
                            print("Skipping element with null date: $element");
                          }
                          return false;
                        }

                        // Remove any extra whitespace
                        String cleanedDate = element.date!.trim();

                        // Split the date string into day, month, and year
                        List<String> dateParts = cleanedDate.split('-');
                        if (dateParts.length != 3) {
                          if (kDebugMode) {
                            print("Skipping element with invalid date format: $element");
                          }
                          return false;
                        }

                        // Reconstruct the date string in "yyyy-MM-dd" format
                        String formattedDate = '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';

                        // Try to parse the formatted date string into a DateTime object
                        DateTime? date = DateTime.tryParse(formattedDate);

                        if (date == null) {
                          if (kDebugMode) {
                            print("Skipping element due to parsing error: $element");
                          }
                          return false;
                        }

                        // Check if the parsed date matches the selectedDate
                        return date.day == controller.selectedDate.value.day &&
                            date.month == controller.selectedDate.value.month &&
                            date.year == controller.selectedDate.value.year;
                      }).toList().length??0;

                      print(count);

                      return Text(
                      "($count)",
                      style: AppTextStyle.mediumTS
                          .copyWith(color: AppColors.black333Color, fontSize: 16),
                    );
                    },
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return HomeFilterBottomSheet(
                          homeController: controller,
                        );
                      },
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: AppColors.blueEFFColor,
                    child: Row(
                      children: [
                        Text("Filter ",
                            style: AppTextStyle.mediumTS.copyWith(
                                color: AppColors.blue2E6Color, fontSize: 16)),
                        Image.asset(
                          AppAssets.filterIcon,
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.listElementCount.value,
                itemBuilder: (context, index) {
                  return TicketCard(
                    ticketId: controller.ticketList.value[index].id ?? '',
                    ticketTitle: controller.ticketList.value[index].title ?? "",
                    ticketTime: controller.ticketList.value[index].time ?? "",
                    ticketPriority:
                        controller.ticketList.value[index].priority ?? "",
                    ticketLocation:
                        controller.ticketList.value[index].location ?? '',
                    ticketStatus:
                        controller.ticketList.value[index].status ?? "",
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
