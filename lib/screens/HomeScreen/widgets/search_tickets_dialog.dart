import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:service_call_management/screens/HomeScreen/widgets/ticket_card.dart';
import 'package:service_call_management/utils/app_assets.dart';

import '../../../Models/TicketsModel.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_test_style.dart';
import '../../SignInScreen/sign_in_screen.dart';
import '../home_screen_controller.dart';

class SearchTicketsDialog extends StatelessWidget {
  const SearchTicketsDialog({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Ticket'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: CustomTextFormField(
                  hint: 'Enter Ticket ID / Title',
                  prefix_icon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      AppAssets.searchIcon,
                      color: AppColors.blue2F6Color,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  title: 'Search Ticket',
                  isRequired: false,
                  onChanged: (value) {
                    controller.searchText.value = value;
                  },
                )),
          ),
          Expanded(
            child: Obx(() {
              List<ServiceData> searchResult =
                  controller.ticketList.where((element) {
                return "${element.subject}#${element.serviceCallNo}"
                        .toLowerCase()
                        .contains(controller.searchText.value.toLowerCase());
              }).toList();
              return Container(
                color: AppColors.blueEFFColor,
                child: searchResult.isEmpty
                    ? Center(
                        child: Text(
                          "No Data Found.",
                          style: AppTextStyle.semiBoldTS
                              .copyWith(color: AppColors.grey848Color),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: searchResult.length,
                        itemBuilder: (context, index) {
                          return TicketCard(
                            ticketSubStatus: searchResult[index].subStatus ?? "N/A",
                            ticketId: searchResult[index].serviceCallNo ?? "",
                            ticketTitle: searchResult[index].subject ?? "N/A",
                            ticketTime: searchResult[index].time ?? "N/A",
                            ticketLocation:
                                searchResult[index].address ?? "N/A",
                            ticketStatus:
                                searchResult[index].callStatus ?? "N/A",
                            manuSN: searchResult[index].manuSN ?? "N/A",
                            model: searchResult[index].model ?? "N/A",
                            ticketPriority:
                                searchResult[index].priority ?? "N/A",
                            startDate: searchResult[index].generateDate ?? "N/A",
                            endDate: searchResult[index].endDate ?? "N/A",
                            customerName: searchResult[index].customerName ?? "N/A",
                            contactPerson: searchResult[index].contactPerson ?? "N/A",
                            contactNumber: searchResult[index].contactNumber ?? "",
                            triage: searchResult[index].triage ?? "N/A",
                            duration: searchResult[index].duration ?? "N/A",
                            remark: searchResult[index].remarks ?? "N/A",
                          );
                        },
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
