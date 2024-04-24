import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/inventory_model.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_url.dart';

class StockController extends GetxController {
  TabController? headerTab;
  RxString dropdownValue = 'All'.obs;
  List<String> requestTypes = ['All', 'Open', 'Close'];
  RxInt selectedIndex = 0.obs;
  InventoryModel? productModel;
  RxString callId = "05".obs;
  List<Datum> productData = <Datum>[];
  RxList<Datum> subProductList = <Datum>[].obs;
  List<Datum> transferData = <Datum>[];
  RxList<Datum> subTransferList = <Datum>[].obs;
  final _api = NetWorkApiService();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getPurchaseRequestList();
  }

  void changeIndex(int index) {
    if(index == selectedIndex.value){
      return;
    }else {
      index == 0 ? getPurchaseRequestList() : getTransferRequestList();
      selectedIndex.value = index;
    }
  }

  void changeDropDownValue(String? value) {
    dropdownValue.value = value!;
    getSubProductList();
    getSubTransferList();
    update();
  }

  Future<void> getPurchaseRequestList() async {
    var data = await _api.postApi(AppUrl.prList, {
      "CallId": callId.value,
      "Page": 0,
    });
    if (data["Result"] == 0) {
      productModel = null;
    } else {
      productModel = InventoryModel.fromJson(data);
    }
    productData = productModel?.data ?? [];
    getSubProductList();
    update();
  }

  Future<void> getTransferRequestList() async {
    var data = await _api.postApi(AppUrl.itList, {
      "CallId": callId.value,
      "Page": 0,
    });
    if (data["Result"] == 0) {
      productModel = null;
    } else {
      productModel = InventoryModel.fromJson(data);
    }
    transferData = productModel?.data ?? [];
    getSubTransferList();
    update();
  }

  void getSubProductList() {
    subProductList.clear();
    for (var element in productData) {
      if (element.docStatus == dropdownValue.value) {
        subProductList.add(element);
      }
    }
  }

  void getSubTransferList() {
    subTransferList.clear();
    for (var element in transferData) {
      if (element.docStatus == dropdownValue.value ||dropdownValue.value == 'All') {
        subTransferList.add(element);
      }
    }
  }
}
