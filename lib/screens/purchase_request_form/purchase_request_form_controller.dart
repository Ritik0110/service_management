import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/warehouse_model.dart';
import 'package:service_call_management/screens/choose_items/choose_items.dart';


import '../../services/network_api_services.dart';

class PurchaseFormController extends GetxController {
  WarehouseModel warehouses = WarehouseModel();
  List<DropdownMenuItem<String>>? warehouseList =
      <DropdownMenuItem<String>>[].obs;
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString selectedFromWarehouse = "".obs;
  RxString selectedToWarehouse = "".obs;
  String callID = "";


  onFromWarehouseChange(String? value) {
    selectedFromWarehouse.value = value!;
    update();
  }

  onToWarehouseChange(String? value) {
    selectedToWarehouse.value = value!;
    update();
  }

  submitForm() {
    if (formKey.currentState!.validate()) {
      /*if (selectedToWarehouse.value == selectedFromWarehouse.value) {
        Get.snackbar("Please Select Different warehouses", "",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.black191Color,
            margin: const EdgeInsets.all(0),
            borderRadius: 0,
            colorText: AppColors.whiteColor,
            duration: const Duration(seconds: 3));
      } else {*/
        Get.to(ChooseItems(
          /*fromWarehouse: selectedFromWarehouse.value,
          toWarehouse: selectedToWarehouse.value,*/
          callID: callID,
          requirementDate: selectedDate,
        ));
      //}
    }
  }

  DateTime selectedDate = DateTime.now();
  final TextEditingController dateController = TextEditingController();

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year+2),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text =
          "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
    }
  }
}
