import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/Inventory_transfer_model.dart';
import 'package:service_call_management/Models/ItemModel.dart';
import 'package:service_call_management/Models/firm_model.dart';
import 'package:service_call_management/Models/purchase_model.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_url.dart';

import '../../Models/TicketsModel.dart';

class ChooseItemController extends GetxController {
  RxInt totalItems = 0.obs;
  List<ItemData> selectedItemsList = <ItemData>[].obs;
  final _api = NetWorkApiService();
  ItemModel model = ItemModel();
  FirmModel firms = FirmModel();
  final searchController = TextEditingController(
    text: "",
  );
  // Map contains data where groupCode marks as key
  var subLists = <String, List<ItemData>>{}.obs;
  //contains sublist of each groupCode
  //RxList<List<ItemData>> groupItems = <List<ItemData>>[].obs;
  RxList<ItemData> searchItems = <ItemData>[].obs;
  late InventoryTransferModel iTModel;
  late PurchaseRequestModel pRModel;
  RxBool isSearch = false.obs;
  var subQty = <String, num>{}.obs;
  DateTime? requireDate;
  late ServiceData data;
  RxList firmData = [].obs;

  @override
  void onReady() {
    super.onReady();
    //getItems();
    getFirms();
  }

  Future getFirms() async {
    firmData.clear();
    subQty.clear();
    totalItemsCount();
    var data = await _api.getApi(AppUrl.firmList);
    firms = FirmModel.fromJson(data);
    firms.listFirm?.forEach((element) {
      firmData.add({
        'firmName': element.firmName,
        'data': <ItemData>[],
        'page': 1,
        'is_null': false,
        'scroll': ScrollController()
      });
    });
    for (int i = 0; i < firmData.length; i++) {
      getItems(
          firmName: firmData[i]['firmName'],
          page: firmData[i]['page'],
          index: i);
    }
    initScroll();
  }
  initScroll(){
    for (int i = 0; i < firmData.length; i++) {
      firmData[i]['scroll'] = ScrollController();
      firmData[i]['scroll'].addListener(() {
        if (  firmData[i]['scroll'].position.pixels ==
            firmData[i]['scroll'].position.maxScrollExtent) {
          getItems(
              firmName:   firmData[i]['firmName'],
              page: firmData[i]['page'],
              index: i);
        }
      });
    }
  }

  Future getItems(
      {required String firmName, required int page, required int index}) async {
    if (firmData[index]["is_null"] == false) {
      var data = await _api
          .postApi(AppUrl.getItems, {"FirmName": firmName, "page": page});
      firmData[index]["page"] = page + 1;
      model = ItemModel.fromJson(data);
      if (model.itemData == [] || model.itemData == null) {
        firmData[index]["is_null"] = true;
      }else{
        firmData[index]["data"].addAll(model.itemData);
        model.itemData?.forEach((element) {
          subQty['${element.itemCode}-${element.warehouse}'] = 0;
        });
      }
    }
    update();
    // searchItems.clear();
    // subLists.clear();
    //mapping data into sub list using each group code

    // if (!subLists.containsKey(element.firmName)) {
    //   subLists[element.firmName.toString()] = [];
    // }
    //subLists[element.firmName]!.add(element);

    //converting map into list of grouped item list
    // groupItems.value = subLists.values.toList();
    // searchItems.addAll(groupItems);
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
      for (var element in firmData) {
        List<ItemData> temp = [];
        for (var e in element['data']) {
          if (e.itemName!.toLowerCase().contains(searchValue!.toLowerCase())) {
            temp.add(e);
          } else if (e.itemCode!
              .toLowerCase()
              .contains(searchValue.toLowerCase())) {
            temp.add(e);
          }
        }
        if (temp.isNotEmpty) {
          searchItems.addAll(temp);
        }
      }
    } else {
      searchItems.clear();
    }
    update();
  }

  increaseItem1(ItemData data) {
    !selectedItemsList.contains(data) ? selectedItemsList.add(data) : null;
    subQty['${data.itemCode}-${data.warehouse}'] =
        (subQty['${data.itemCode}-${data.warehouse}']! + 1);
    totalItemsCount();
    update();
  }

  decreaseItem1(ItemData data) {
    if (subQty['${data.itemCode}-${data.warehouse}']! > 0) {
      subQty['${data.itemCode}-${data.warehouse}'] =
          (subQty['${data.itemCode}-${data.warehouse}']! - 1);
      subQty['${data.itemCode}-${data.warehouse}'] == 0
          ? selectedItemsList.remove(data)
          : null;
      totalItemsCount();
      update();
    }
  }

  removeItem(ItemData data) {
    subQty['${data.itemCode}-${data.warehouse}'] = 0;
    selectedItemsList.remove(data);
    totalItemsCount();
    update();
  }

  /* Future submitForInventory() async {
    List<StockTransferLine> items = [];
    for (var element in selectedItemsList) {
      items.add(StockTransferLine(
          itemCode: element.itemCode!,
          quantity: subQty['${element.itemCode}-${element.warehouse}']!.toInt(),
          fromWarehouseCode: element.warehouse!,
          warehouseCode: toWarehouse));
    }
    iTModel = InventoryTransferModel(docDate: DateTime.now(), stockTransferLines: items, uCallid: '', uAisitrsplit: '');
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
          quantity: subQty['${element.itemCode}-${element.warehouse}']!.toInt(),
          warehouseCode: element.warehouse!));
    }
    pRModel = PurchaseRequestModel(
      requriedDate: requireDate!,
      documentLines: items,
      uCallid: ""
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
  }*/
}
