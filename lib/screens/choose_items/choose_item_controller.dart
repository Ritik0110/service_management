import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/Inventory_transfer_model.dart';
import 'package:service_call_management/Models/ItemModel.dart';
import 'package:service_call_management/Models/purchase_model.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_url.dart';

class ChooseItemController extends GetxController {
  RxInt totalItems = 0.obs;
  List<ItemData> selectedItemsList = <ItemData>[].obs;
  final _api = NetWorkApiService();
  ItemModel model = ItemModel();
  // Map contains data where groupCode marks as key
  var subLists = <String, List<ItemData>>{}.obs;
  //contains sublist of each groupCode
  RxList<List<ItemData>> groupItems = <List<ItemData>>[].obs;
  late TransferModel iTModel;
  late PurchaseModel pRModel;
  var subQty = <String, num>{}.obs;
  RxString fromWarehouse = "02".obs;
  String toWarehouse = "";
  DateTime? requireDate;

  @override
  void onReady() {
    super.onReady();
    getItems();
  }

  Future getItems() async {
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    var data = await _api.postApi(AppUrl.getItems, {
      "WhsCode": fromWarehouse.value,
    });
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    model = ItemModel.fromJson(data);
    subLists.clear();
    //mapping data into sub list using each group code
    model.itemData?.forEach((element) {
      if (!subLists.containsKey(element.groupName)) {
        subLists[element.groupName.toString()] = [];
      }
      subLists[element.groupName]!.add(element);
      subQty['${element.itemCode}'] = 0;
    });
    //converting map into list of grouped item list
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

  Future submitForInventory() async {
    List<StockTransferLine> items = [];
    for (var element in selectedItemsList) {
      items.add(StockTransferLine(
          itemCode: element.itemCode!,
          quantity: subQty[element.itemCode!]!.toInt(),
          fromWarehouseCode: fromWarehouse.value,
          warehouseCode: toWarehouse));
    }
    print(items);
    iTModel = TransferModel(docDate: DateTime.now(), stockTransferLines: items);
    print(iTModel.toJson());
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    var data = await _api.postApi(
        AppUrl.inventoryTransfer, jsonEncode(iTModel.toJson()));
    print(data);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  Future submitForPurchase() async {
    List<DocumentLine> items = [];
    for (var element in selectedItemsList) {
      items.add(DocumentLine(
          itemCode: element.itemCode!,
          quantity: subQty[element.itemCode!]!.toInt(),
          warehouseCode: fromWarehouse.value));
    }
    pRModel = PurchaseModel(
      requriedDate: requireDate!,
      documentLines: items,
    );
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    var data = await _api.postApi(
        AppUrl.purchaseRequest, jsonEncode(pRModel.toJson()));
    print(data);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
