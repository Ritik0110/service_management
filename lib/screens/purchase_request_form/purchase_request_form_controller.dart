import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/warehouse_model.dart';
import 'package:service_call_management/screens/choose_items/choose_items.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_url.dart';

import '../../services/network_api_services.dart';

class PurchaseFormController extends GetxController {
  WarehouseModel warehouses = WarehouseModel();
  List<DropdownMenuItem<String>>? warehouseList =
      <DropdownMenuItem<String>>[].obs;
  final _api = NetWorkApiService();
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString selectedFromWarehouse = "".obs;
  RxString selectedToWarehouse = "".obs;
  @override
  void onReady() {
    super.onReady();
    getWareHouse();
  }

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
      if (selectedToWarehouse.value == selectedFromWarehouse.value) {
        Get.snackbar("Please Select Different warehouses", "",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.black191Color,
            margin: const EdgeInsets.all(0),
            borderRadius: 0,
            colorText: AppColors.whiteColor,
            duration: const Duration(seconds: 3));
      } else {
        Get.to(ChooseItems(
          fromWarehouse: selectedFromWarehouse.value,
          toWarehouse: selectedToWarehouse.value,
          requirementDate: selectedDate,
        ));
      }
    }
  }

  getWareHouse() async {
    isLoading.value = true;
    var data = await _api.getApi(AppUrl.getWarehouses);
    warehouses = WarehouseModel.fromJson(data);
    warehouseList = warehouses.wareHouse!
        .map((e) => DropdownMenuItem<String>(
              value: e.whsCode.toString(),
              child: Text(e.whsName!),
            ))
        .toList();
    isLoading.value = false;
    update();
  }

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
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    }
  }
}
