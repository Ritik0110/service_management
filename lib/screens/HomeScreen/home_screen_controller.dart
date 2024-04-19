
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:service_call_management/Models/TicketsModel.dart';
import 'package:service_call_management/utils/api_helper.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/app_variables.dart';

import '../../utils/app_colors.dart';

enum Status { all, open, close }

enum Priority { all, low, medium, high }

class HomeControler extends GetxController {
  final selectedDate = DateTime.now().obs;
  final RxList<ServiceData> ticketList = <ServiceData>[].obs;
  final RxInt listElementCount = 0.obs;
  final status = Status.all.obs;
  final priority = Priority.all.obs;
  final tempStatus = Status.all.obs;
  final tempPriority = Priority.all.obs;
  final searchText = "".obs;
  final Rx<TicketsModel> ticketsModel = TicketsModel().obs;

  Future<void> setSelectDate(DateTime date) async {
    selectedDate.value = date;
    await loadApiData();
    //applyFilter();
  }
@override
  void onReady() {
    // TODO: implement onReady
  loadApiData();
    super.onReady();
  }
  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    super.onInit();
  }


  Future<void> loadApiData() async {
    Get.dialog(Center(child: CircularProgressIndicator(),),barrierDismissible: false);
    String result = await ApiHelper.getTickets(
      DateFormat("yyyy-MM-dd").format(selectedDate.value),
    )??"";
    if(Get.isDialogOpen??false){
      Get.back();
    }
    if(result == "1"){
    ticketsModel.value = AppVariables.ticketsModel;
    ticketList.value = ticketsModel.value.serviceData ?? [];
    listElementCount.value = ticketList.length;
    applyFilter();
    }else{
      Get.defaultDialog(barrierDismissible: false,onWillPop: () async {
        return await  false;
      },title: "Error",titleStyle: AppTextStyle.boldTS.copyWith(fontSize: 18,color: AppColors.redE25Color,),content: Text(result,style: AppTextStyle.semiBoldTS,textAlign: TextAlign.left),onConfirm: (){
        loadApiData();
      },confirm: ElevatedButton(onPressed: () {
       Get.back();
       loadApiData();
      }, child: const Text("Retry"),));
    }

  }

  void applyFilter() {
    List<ServiceData> filteredList =
        ticketsModel?.value.serviceData?.where((element) {
              if (element.generateDate == null) {
                return false;
              }

              // Remove any extra whitespace
              String cleanedDate = element.generateDate!.trim();

              // Split the date string into day, month, and year
              List<String> dateParts = cleanedDate.split('/');
              if (dateParts.length != 3) {
                print("Skipping element with invalid date format: $element");
                return false;
              }

              // Reconstruct the date string in "yyyy-MM-dd" format
              String formattedDate =
                  '${dateParts[2]}-${dateParts[0]}-${dateParts[1]}';

              // Try to parse the formatted date string into a DateTime object
              DateTime? date = DateTime.tryParse(formattedDate);
              if (date == null) {
                print("Skipping element due to parsing error: $element");
                return false;
              }

              // Check if the parsed date matches the selectedDate
              return date.day == selectedDate.value.day &&
                  date.month == selectedDate.value.month &&
                  date.year == selectedDate.value.year;
            }).toList() ??
            [];
    // List<Data> filteredList = ticketsModel.data??[];
    if (status.value == Status.open) {
      filteredList.removeWhere(
          (element) => element.callStatus?.toLowerCase() != "open");
    }
    if (status.value == Status.close) {
      filteredList.removeWhere(
          (element) => element.callStatus?.toLowerCase() != "close");
    }

    ticketList.value = filteredList;
    if (listElementCount.value == ticketList.length) {
      listElementCount.value = 0;
    }
    listElementCount.value = ticketList.length;
  }
}
