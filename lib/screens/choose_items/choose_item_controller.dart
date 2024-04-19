import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/ItemModel.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_url.dart';

class ChooseItemController extends GetxController {
  RxInt totalItems = 0.obs;
  var selectedItems = [].obs;
  List<ItemData> selectedItemsList = <ItemData>[].obs;
  final _api = NetWorkApiService();
  ItemModel model = ItemModel();
  var subLists = <String, List<ItemData>>{}.obs;
  RxList<List<ItemData>> groupItems = <List<ItemData>>[].obs;
  var subQty = <String, num>{}.obs;
  RxString whsCode = "02".obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getItems();
  }

  Future getItems() async {
    Get.dialog(const Center(child: CircularProgressIndicator(),),barrierDismissible: false);
    var data = await _api.postApi(AppUrl.getItems, {
      "WhsCode": "${whsCode.value}",
    });
    if(Get.isDialogOpen??false){
      Get.back();
    }
    model = ItemModel.fromJson(data);
    model.itemData?.forEach((element) {
      if (!subLists.containsKey(element.groupName)) {
        subLists[element.groupName.toString()] = [];
      }
      subLists[element.groupName]!.add(element);
      subQty['${element.itemCode}'] = 0;
    });
    groupItems.value = subLists.values.toList();
  }

  totalItemsCount() {
    totalItems.value = 0;
    subQty.forEach((key, value) {
      totalItems.value += value.toInt();
    });
  }

  increaseItem1(ItemData data) {
    if (subQty[data.itemCode]! < data.quantity!) {
      !selectedItemsList.contains(data) ? selectedItemsList.add(data) : null;
      subQty[data.itemCode!] = (subQty[data.itemCode]! + 1);
      totalItemsCount();
      update();
    }
  }

  decreaseItem1(ItemData data) {
    if (subQty[data.itemCode]! > 0) {
      subQty[data.itemCode!] = (subQty[data.itemCode]! - 1);
      subQty[data.itemCode] == 0 ? selectedItemsList.remove(data) : null;
      totalItemsCount();
      update();
    }
  }

  removeItem(ItemData data) {
    subQty[data.itemCode!] = 0;
    selectedItemsList.remove(data);
    totalItemsCount();
    update();
  }
}
