import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/choose_items/choose_item_controller.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

import '../../Models/Inventory_transfer_model.dart';
import '../../Models/purchase_model.dart';
import '../../Models/warehouse_model.dart';
import '../../common_widgets/common_button.dart';
import '../../services/network_api_services.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_test_style.dart';
import '../../utils/app_url.dart';
import '../HomeScreen/home_screen.dart';

class OrderReviewController extends GetxController {
  final _api = NetWorkApiService();
  WarehouseModel warehouses = WarehouseModel();
  final controller = Get.put(ChooseItemController());
  List<StockTransferLine> transferItems = [];
  List<DocumentLine> purchaseItems = [];
  late TransferModel transferModel;
  late PurchaseModel purchaseModel;
  List<DropdownMenuItem<String>>? warehouseList =
      <DropdownMenuItem<String>>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getWareHouse() async {
    var data = await _api.getApi(AppUrl.getWarehouses);
    warehouses = WarehouseModel.fromJson(data);
    warehouseList = warehouses.wareHouse!
        .map((e) => DropdownMenuItem<String>(
              value: e.whsCode.toString(),
              child: Text(e.whsName!),
            ))
        .toList();
    update();
  }

  submitOrder() {
    if (controller.selectedItemsList.isNotEmpty) {
      for (var element in controller.selectedItemsList) {
        if (element.quantity! <
            controller.subQty['${element.itemCode}-${element.warehouse}']!
                .toInt()) {
          transferItems.add(StockTransferLine(
              itemCode: element.itemCode!,
              quantity: controller
                  .subQty['${element.itemCode}-${element.warehouse}']!
                  .toInt(),
              fromWarehouseCode: element.warehouse!,
              warehouseCode: ""));
        }else{
          purchaseItems.add(DocumentLine(
              itemCode: element.itemCode!,
              quantity: controller
                  .subQty['${element.itemCode}-${element.warehouse}']!
                  .toInt(),
              warehouseCode: element.warehouse!));
        }
      }
    }
  }

  Future submitForInventory() async {
    for (var element in controller.selectedItemsList) {
      transferItems.add(StockTransferLine(
          itemCode: element.itemCode!,
          quantity: controller
              .subQty['${element.itemCode}-${element.warehouse}']!
              .toInt(),
          fromWarehouseCode: element.warehouse!,
          warehouseCode: ""));
    }
    transferModel = TransferModel(
        docDate: DateTime.now(), stockTransferLines: transferItems);
    var data = await _api.postApi(
        AppUrl.inventoryTransfer, jsonEncode(transferModel.toJson()));
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                15.sizedBoxHeight,
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.green33AColor,
                  size: 80,
                ),
                Text(
                  data["error"] ??
                      "Your Request hase been submitted successfully!",
                  style: AppTextStyle.black191medium16,
                  textAlign: TextAlign.center,
                ),
                20.sizedBoxHeight,
                CommonMaterialButton(
                  spacing: false,
                  buttonText: "Back to Home",
                  onTap: () {
                    Get.offAll(const HomeScreen());
                  },
                  width: 200,
                ),
                10.sizedBoxHeight
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future submitForPurchase() async {
    purchaseModel = PurchaseModel(
      requriedDate: controller.requireDate!,
      documentLines: purchaseItems,
    );
    var data = await _api.postApi(
        AppUrl.purchaseRequest, jsonEncode(purchaseModel.toJson()));
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                15.sizedBoxHeight,
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.green33AColor,
                  size: 80,
                ),
                Text(
                  data["error"] ??
                      "Your Request hase been submitted successfully!",
                  style: AppTextStyle.black191medium16,
                  textAlign: TextAlign.center,
                ),
                20.sizedBoxHeight,
                CommonMaterialButton(
                  spacing: false,
                  buttonText: "Back to Home",
                  onTap: () {
                    Get.offAll(const HomeScreen());
                  },
                  width: 200,
                ),
                10.sizedBoxHeight
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
