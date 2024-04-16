import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/repository/models/product_model.dart';

class PurchaseFormController extends GetxController {
  List seriesList = [];
  List wareHouseList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    seriesList = DataList.productList;
    wareHouseList = DataList.warehouseList;
  }

  RxInt selectedSeriesNo = 0.obs;
  RxInt selectedToWareHouse = 0.obs;
  RxInt selectedFromWareHouse = 0.obs;
  DateTime selectedDate = DateTime.now();
  final TextEditingController dateController = TextEditingController();

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text =
          "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
    }
  }
}
