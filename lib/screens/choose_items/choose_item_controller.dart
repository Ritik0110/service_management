import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/Inventory_transfer_model.dart';
import 'package:service_call_management/Models/ItemModel.dart';
import 'package:service_call_management/Models/purchase_model.dart';
import 'package:service_call_management/common_widgets/common_button.dart';
import 'package:service_call_management/screens/HomeScreen/home_screen.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/app_url.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

class ChooseItemController extends GetxController {
  RxInt totalItems = 0.obs;
  List<ItemData> selectedItemsList = <ItemData>[].obs;
  final _api = NetWorkApiService();
  ItemModel model = ItemModel();
  final searchController = TextEditingController();
  // Map contains data where groupCode marks as key
  var subLists = <String, List<ItemData>>{}.obs;
  //contains sublist of each groupCode
  RxList<List<ItemData>> groupItems = <List<ItemData>>[].obs;
  RxList<List<ItemData>> searchItems = <List<ItemData>>[].obs;
  late TransferModel iTModel;
  late PurchaseModel pRModel;
  RxBool isSearch = false.obs;
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
    var data = await _api.postApi(AppUrl.getItems, {
      "WhsCode": fromWarehouse.value,
    });
    model = ItemModel.fromJson(data);
    searchItems.clear();
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
    searchItems.addAll(groupItems);
  }

  void setSearch() {
    isSearch.value = isSearch.value ? false : true;
  }

  totalItemsCount() {
    totalItems.value = 0;
    subQty.forEach((key, value) {
      totalItems.value += value.toInt();
    });
  }

  void searchedList(String? searchValue) {
    if (searchController.text.isNotEmpty) {
      searchItems.clear();
      for (var element in groupItems) {
        List<ItemData> temp = [];
        for (var e in element) {
          if (e.itemName!.toLowerCase().contains(searchValue!.toLowerCase())) {
            temp.add(e);
          }
        }
        searchItems.add(temp);
      }
    } else {
      searchItems.clear();
      searchItems.addAll(groupItems);
    }
  }

  increaseItem1(ItemData data) {
      !selectedItemsList.contains(data) ? selectedItemsList.add(data) : null;
      subQty[data.itemCode!] = (subQty[data.itemCode]! + 1);
      totalItemsCount();
      update();
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
    iTModel = TransferModel(docDate: DateTime.now(), stockTransferLines: items);
    var data = await _api.postApi(
        AppUrl.inventoryTransfer, jsonEncode(iTModel.toJson()));
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
    var data = await _api.postApi(
        AppUrl.purchaseRequest, jsonEncode(pRModel.toJson()));
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
