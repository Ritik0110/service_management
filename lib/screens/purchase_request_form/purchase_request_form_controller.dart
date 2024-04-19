import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/warehouse_model.dart';
import 'package:service_call_management/utils/app_url.dart';

import '../../services/network_api_services.dart';

class PurchaseFormController extends GetxController {
  WarehouseModel warehouses = WarehouseModel();
  List<DropdownMenuItem<String>>? warehouseList = <DropdownMenuItem<String>>[].obs;
  final _api = NetWorkApiService();
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString selectedFromWarehouse = "".obs;
  RxString selectedToWarehouse = "".obs;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getWareHouse();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  onfromWarehouseChange(String? value) {
    selectedFromWarehouse.value = value!;
    update();
  }
  ontoWarehouseChange(String? value) {
    selectedToWarehouse.value = value!;
    update();
  }


  getWareHouse() async {
    Get.dialog(const Center(child: CircularProgressIndicator(),),barrierDismissible: false);
    isLoading.value = true;
    var data = await _api.getApi(AppUrl.getWarehouses);
    warehouses = WarehouseModel.fromJson(data);
    print(data);

    warehouseList = warehouses.wareHouse!.map((e) => DropdownMenuItem<String>(
      child: Text(e.whsName!),
      value: e.whsCode.toString(),

    )).toList();
    warehouseList;
    print("series list ${warehouseList?[0].value}");
    isLoading.value = false;
    if(Get.isDialogOpen??false){
      Get.back();
    }
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
          "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
    }
  }
}
