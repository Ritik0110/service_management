import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:service_call_management/Models/TicketsModel.dart';


enum Status { all, open, close }
enum Priority { all, low, medium, high}
class HomeControler extends GetxController {
  final selectedDate = DateTime.now().obs;
  final RxList<Data>ticketList = <Data>[].obs;
  final RxInt listElementCount = 0.obs;
  final status = Status.all.obs;
  final priority = Priority.all.obs;
  final tempStatus = Status.all.obs;
  final tempPriority = Priority.all.obs;
  final searchText = "".obs;
  final TicketsModel ticketsModel = TicketsModel.fromJson(jsonDecode("""{
  "resultFlag": 1,
  "data": [
  {
  "id": "405514",
  "date": "02-04-2024",
  "title": "Computer Not Working",
  "time": "01:30 PM",
  "priority": "High",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Open"
  },
  {
  "id": "405515",
  "date": "01-04-2024",
  "title": "USB Device Not Connect",
  "time": "01:30 PM",
  "priority": "Low",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Open"
  },
  {
  "id": "405516",
  "date": "01-04-2024",
  "title": "Computer Fan Not Working  ",
  "time": "01:30 PM",
  "priority": "Low",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Close"
  },
  {
  "id": "405517",
  "date": "01-04-2024",
  "title": "Display Not Working",
  "time": "01:30 PM",
  "priority": "Medium",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Close"
  },
  {
  "id": "405518",
  "date": "02-04-2024",
  "title": "Computer Not Working",
  "time": "01:30 PM",
  "priority": "High",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Open"
  },
  {
  "id": "405519",
  "date": "02-04-2024",
  "title": "USB Device Not Connect",
  "time": "01:30 PM",
  "priority": "Low",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Open"
  },
  {
  "id": "405520",
  "date": "02-04-2024",
  "title": "Computer Fan Not Working",
  "time": "02:30 PM",
  "priority": "Low",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Close"
  },
  {
  "id": "405521",
  "date": "02-04-2024",
  "title": "Display Not Working",
  "time": "02:30 PM",
  "priority": "Medium",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Close"
  },
  {
  "id": "405521",
  "date": "01-04-2024",
  "title": "Display Not Working",
  "time": "03:30 PM",
  "priority": "Medium",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Open"
  },
  {
  "id": "405522",
  "date": "03-04-2024",
  "title": "Display Not Working",
  "time": "02:30 PM",
  "priority": "High",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Close"
  },
  {
  "id": "405523",
  "date": "03-04-2024",
  "title": "Computer Fan Not Working",
  "time": "03:30 PM",
  "priority": "Medium",
  "location": "Gitschiner Str., Berlin Germeany",
  "status": "Open"
  }
  ]
}"""));

  void setSelectDate(DateTime date) {

    selectedDate.value = date;
    applyFilter();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    ticketList.value = ticketsModel.data??[];
    listElementCount.value = ticketList.length;
    applyFilter();
    super.onInit();
  }

  void applyFilter() {
    List<Data> filteredList = ticketsModel.data?.where((element) {
      if (element.date == null) {
        return false;
      }

      // Remove any extra whitespace
      String cleanedDate = element.date!.trim();

      // Split the date string into day, month, and year
      List<String> dateParts = cleanedDate.split('-');
      if (dateParts.length != 3) {
        print("Skipping element with invalid date format: $element");
        return false;
      }

      // Reconstruct the date string in "yyyy-MM-dd" format
      String formattedDate = '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';

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
    }).toList()??[];
      // List<Data> filteredList = ticketsModel.data??[];
      if(status.value == Status.open){
        filteredList.removeWhere((element) => element.status?.toLowerCase() != "open");
      }
      if(status.value == Status.close){
        filteredList.removeWhere((element) => element.status?.toLowerCase() != "close");
      }
      if(priority.value == Priority.low){
        filteredList.removeWhere((element) => element.priority?.toLowerCase() != "low");
      }
      if(priority.value == Priority.medium){
        filteredList.removeWhere((element) => element.priority?.toLowerCase() != "medium");
      }
      if(priority.value == Priority.high){
        filteredList.removeWhere((element) => element.priority?.toLowerCase() != "high");
      }
      ticketList.value = filteredList;
      if(listElementCount.value == ticketList.length) {
        listElementCount.value = 0;
      }
      listElementCount.value = ticketList.length;

  }
}