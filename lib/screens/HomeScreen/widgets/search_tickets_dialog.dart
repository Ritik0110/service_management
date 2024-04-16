import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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

  final HomeControler controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
      body:   Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: CustomTextFormField(
                   hint: 'Enter Ticket ID / Title',
                  prefix_icon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(AppAssets.searchIcon,color: AppColors.blue2F6Color,height: 20,width: 20,),
                  ),
                  title: 'Search Ticket', isRequired: false,onChanged: (value){
                  controller.searchText.value = value;
                },
                )),
          ),
          Expanded(
            child: Obx(
                    () {
                  List<ServiceData> searchResult =  controller.ticketList.where((element) {
                    return "${element.subject}#${element.serviceCallNo}".toLowerCase()?.contains(controller.searchText.value.toLowerCase())??false;}).toList();
                  return Container(
                    color:AppColors.blueEFFColor,
                    child:searchResult.isEmpty?Center(child: Text("No Data Found.",style: AppTextStyle.semiBoldTS.copyWith(color: AppColors.grey848Color),),): ListView.builder(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,

                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return  TicketCard(ticketId:searchResult[index].serviceCallNo??"", ticketTitle: searchResult[index].subject??"", ticketTime: searchResult[index].time??"", ticketLocation: searchResult[index].address??"", ticketStatus: searchResult[index].callStatus??"",manuSN: "Not Provided",model: "Not Provided ",);
                      },),
                  );}
            ),
          ),
        ],
      ),



    );
  }
}