import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/common_widgets/common_card.dart';
import 'package:service_call_management/screens/choose_items/choose_item_controller.dart';


import '../../Models/Inventory_transfer_model.dart';
import '../../Models/purchase_model.dart';
import '../../Models/warehouse_model.dart';
import '../../services/network_api_services.dart';
import '../../utils/app_url.dart';

class OrderReviewController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getWareHouse();
  }

  final _api = NetWorkApiService();
  WarehouseModel warehouses = WarehouseModel();
  final controller = Get.put(ChooseItemController());
  List<StockTransferLine> transferItems = [];
  List<DocumentLine> purchaseItems = [];
  late InventoryTransferModel transferModel;
  late PurchaseRequestModel purchaseModel;
  List<DropdownMenuItem<String>>? warehouseList =
      <DropdownMenuItem<String>>[].obs;
  String selectedWarehouse = "";
  bool wCode = false;

  getWareHouse() async {
    var data = await _api.getApi(AppUrl.getWarehouses);
    warehouses = WarehouseModel.fromJson(data);
    warehouseList = warehouses.wareHouse!
        .map((e) => DropdownMenuItem<String>(
              value: e.whsCode.toString(),
              child: Text(e.whsName!),
            ))
        .toList();
  }

  submitOrder() {
    transferItems.clear();
    purchaseItems.clear();
    if (controller.selectedItemsList.isNotEmpty) {
      for (var element in controller.selectedItemsList) {
        if (element.quantity! <
            controller.subQty['${element.itemCode}-${element.warehouse}']!
                .toInt()) {
          if (element.quantity != 0) {
            var purchaseQty = controller
                    .subQty['${element.itemCode}-${element.warehouse}']!
                    .toInt() -
                element.quantity!;
            wCode = element.warehouse == "DA" ? true : false;
            transferItems.add(StockTransferLine(
                itemCode: element.itemCode!,
                quantity: element.quantity!.toInt(),
                fromWarehouseCode: element.warehouse!,
                warehouseCode: "SW"));
            purchaseItems.add(DocumentLine(
                itemCode: element.itemCode!,
                quantity: purchaseQty.toInt(),
                warehouseCode: element.warehouse!));
          } else if (element.quantity == 0) {
            purchaseItems.add(DocumentLine(
                itemCode: element.itemCode!,
                quantity: controller
                    .subQty['${element.itemCode}-${element.warehouse}']!
                    .toInt(),
                warehouseCode: element.warehouse!));
          }
        } else {
          wCode = element.warehouse == "DA" ? true : false;
          transferItems.add(StockTransferLine(
              itemCode: element.itemCode!,
              quantity: controller
                  .subQty['${element.itemCode}-${element.warehouse}']!
                  .toInt(),
              fromWarehouseCode: element.warehouse!,
              warehouseCode: "SW"));
        }
      }
    }
    submitReview();
  }

  submitReview() async {
    var iTResponse = await submitForInventory();
    String showText = "";
    bool result = false;
    if(iTResponse["Message"]=="Success"){
      var prResponse = await submitForPurchase();
      if(prResponse["Message"]=="Success"){
        showText = "Your Request has been submitted successfully";
        result = true;
      }else{
        showText = prResponse["Message"];
        result = false;
      }
    }else{
      showText = iTResponse["Message"];
      result = false;
    }
    CommonPopUp.showPopup(result, showText);
  }

  Future submitForInventory() async {
    if (transferItems.isEmpty) {
      return {"Message": "Success"};
    } else {
      transferModel = InventoryTransferModel(
          docDate: controller.requireDate!,
          stockTransferLines: transferItems,
          uCallid: controller.data.serviceCallNo!,
          cardCode: controller.data.customerCode!,
          uAisitrsplit: wCode ? "Y" : "N");
      var data = await _api.postApi(AppUrl.inventoryTransfer,
          jsonEncode(transferModel.toJson()));
      return data;
    }
  }

  Future submitForPurchase() async {
    if (purchaseItems.isEmpty) {
      return {"Message": "Success"};
    } else {
      purchaseModel = PurchaseRequestModel(
          requriedDate: controller.requireDate!,
          documentLines: purchaseItems,
          uCallid: controller.data.serviceCallNo!);
      var data = await _api.postApi(
          AppUrl.purchaseRequest, jsonEncode(purchaseModel.toJson()));
      return data;
    }
  }
}
