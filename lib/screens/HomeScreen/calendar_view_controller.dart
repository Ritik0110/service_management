import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:service_call_management/screens/HomeScreen/home_screen_controller.dart';
import 'package:service_call_management/utils/app_url.dart';

import '../../Models/DateModel.dart';
import '../../Models/TicketsModel.dart';
import '../../services/network_api_services.dart';
import '../../utils/app_variables.dart';

class CalenderController extends GetxController{

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData();
    getDates();
  }
  HomeController controller = Get.find();
  Rx<DateTime> day = DateTime.now().obs;
  RxString selectedDate = DateFormat("dd MMMM yyyy").format(DateTime.now()).obs;
  final RxList<ServiceData> ticketList = <ServiceData>[].obs;
  final Rx<TicketsModel> baseModel = TicketsModel().obs;
  final _api = NetWorkApiService();
  DateModel dates = DateModel();
  RxList selectedEvents = [].obs;


  onDaySelect(DateTime selectedDay, DateTime focusedDay) {
    selectedDate.value = DateFormat('dd MMMM yyyy').format(focusedDay);
    day.value = focusedDay;
    getData();

  }
  onPageChange(DateTime focusedDay) {
    selectedDate.value = DateFormat('dd MMMM yyyy').format(focusedDay);
    day.value = focusedDay;
    getDates();
    getData();
  }


  getData() async{
    ticketList.clear();
    var data = await _api.postApi(AppUrl.getTickets, {
      "date": DateFormat("yyyy-MM-dd").format(day.value),
      "EmpCode": AppVariables.employeeModel.employeeData?[0].employeeCode,
    });

    baseModel.value = TicketsModel.fromJson(data);
    ticketList.value = baseModel.value.serviceData ?? [];
    update();
  }
  getDates()async{
    selectedEvents.clear();
    var data = await _api.postApi(AppUrl.dateOfMonth, {
      "Year": DateFormat("yyyy").format(day.value),
      "Month": DateFormat("MM").format(day.value),
    });
    dates = DateModel.fromJson(data);
    for(var i in dates.dates ?? []){
      selectedEvents.add(i.dates);
    }
    update();
  }

  List setDates(DateTime date){
    for(var ticket in selectedEvents) {
      if (date.day.toString() == ticket.toString() && date.month == day.value.month) {
        return [1];
      }
    }
    return [];
  }
}