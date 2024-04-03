
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/HomeScreen/home_screen_controller.dart';
import 'package:service_call_management/screens/HomeScreen/noification_screen.dart';
import 'package:service_call_management/screens/HomeScreen/widgets/search_tickets_dialog.dart';
import 'package:service_call_management/screens/HomeScreen/widgets/home_bottom_sheet.dart';
import 'package:service_call_management/screens/HomeScreen/widgets/home_date_picker.dart';
import 'package:service_call_management/screens/HomeScreen/widgets/ticket_card.dart';
import 'package:service_call_management/screens/SignInScreen/sign_in_screen.dart';
import 'package:service_call_management/utils/app_preferences.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControler controller = Get.put(HomeControler());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer:  Drawer(
         child: Column(
           children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.blue2F6Color,
                ),
                child: Center(
                  child: Text(
                    'Service Call Management',
                    style: AppTextStyle.white16medium,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Sign Out'),
                onTap: () async {
                  SharedPreferences preferences  = await SharedPreferences.getInstance();
                  preferences.remove(AppPreferences.isLoggedIn);
                  Get.offAll(() => const SignInScreen());
                },
              ),
           ],
         ),
      ),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                controller.searchText.value = '';
                Get.dialog(useSafeArea: false,Dialog.fullscreen(
                  child: SearchTicketsDialog(controller: controller)
                ));
              },
              icon: Image.asset(
                AppAssets.searchIcon,
                height: 20,
              )),
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));

                  },
                  icon: Image.asset(
                    AppAssets.notificationIcon,
                    color: AppColors.whiteColor,
                    height: 22,
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
                      if(controller.ticketsModel==null){
                        return const SizedBox();
                      }
                      int count = controller.ticketsModel?.value.serviceData?.where((element) {
                        if (element.generateDate == null) {
                          if (kDebugMode) {
                            print("Skipping element with null date: $element");
                          }
                          return false;
                        }

                        // Remove any extra whitespace
                        String cleanedDate = element.generateDate!.trim();

                        // Split the date string into day, month, and year
                        List<String> dateParts = cleanedDate.split('/');
                        if (dateParts.length != 3) {
                          if (kDebugMode) {
                            print("Skipping element with invalid date format: $element");
                          }
                          return false;
                        }

                        // Reconstruct the date string in "yyyy-MM-dd" format
                        String formattedDate = '${dateParts[2]}-${dateParts[0]}-${dateParts[1]}';

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
              () => controller.ticketsModel==null?SizedBox(): Container(
                color: AppColors.blueEFFColor,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.listElementCount.value,
                  itemBuilder: (context, index) {
                    return TicketCard(
                      ticketId: controller.ticketList[index].serviceCallNo ?? '',
                      ticketTitle: controller.ticketList[index].subject ?? "",
                      ticketTime: controller.ticketList[index].time ?? "",
                      ticketPriority:
                          controller.ticketList[index].priority ?? "",
                      ticketLocation:
                          controller.ticketList[index].address ?? '',
                      ticketStatus:
                          controller.ticketList[index].callStatus ?? "",
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


