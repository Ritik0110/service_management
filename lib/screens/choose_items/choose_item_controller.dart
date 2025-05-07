import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/Inventory_transfer_model.dart';
import 'package:service_call_management/Models/ItemModel.dart';
import 'package:service_call_management/Models/purchase_model.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_url.dart';

import '../../Models/TicketsModel.dart';

class ChooseItemController extends GetxController {
  RxInt totalItems = 0.obs;
  RxInt pageIndex = 0.obs;
  RxInt mainPageIndex = 0.obs;
  RxInt searchPageIndex = 0.obs;
  RxBool isLoadMore = true.obs;
  RxBool isSearchLoadMore = true.obs;
  RxString searchValue = "".obs;
  List<ItemData> selectedItemsList = <ItemData>[].obs;
  List<ItemData> itemsList = <ItemData>[].obs;
  final _api = NetWorkApiService();
  ItemModel model = ItemModel();
  final searchController = TextEditingController(
    text: "",
  ).obs;
  final scrollController = ScrollController();
  RxList<ItemData> searchItems = <ItemData>[].obs;
  late InventoryTransferModel iTModel;
  late PurchaseRequestModel pRModel;
  RxBool isSearch = false.obs;
  var subQty = <String, num>{}.obs;
  DateTime? requireDate;
  late ServiceData data;

  @override
  void onReady() {
    super.onReady();
    getItems();
  }

  Future getItems(
      {String itemName = "",
      bool refresh = false,
      bool isSearching = false}) async {
    if (refresh) {
      itemsList.clear();
      selectedItemsList.clear();
      searchItems.clear();
      subQty.clear();
      totalItemsCount();
      pageIndex.value = 0;
      searchPageIndex.value = 0;
      isLoadMore.value = true;
    }
    if (isLoadMore.value &&
        (isSearching == false || searchController.value.text.trim() == "")) {
      var data = await _api
          .postApi(AppUrl.getItems, {"itemCode": "", "Page": pageIndex.value});
      model = ItemModel.fromJson(data);
      if (model.itemData == null || model.itemData!.isEmpty) {
        isLoadMore.value = false;
      } else {
        pageIndex.value++;
        itemsList.addAll(model.itemData!);
        model.itemData?.forEach((element) {
          subQty.putIfAbsent(
              '${element.itemCode}-${element.warehouse}', () => 0);
        });
      }
    } else if (isSearching && isSearchLoadMore.value == true) {
      if (searchValue.value != itemName) {
        for (var i in searchItems) {
          if (subQty['${i.itemCode}-${i.warehouse}'] == 0) {
            subQty.remove('${i.itemCode}-${i.warehouse}');
          }
        }
        searchItems.clear();
      }
      searchValue.value = itemName;
      var data = await _api.postApi(AppUrl.getItems,
          {"itemCode": itemName, "Page": searchPageIndex.value});
      model = ItemModel.fromJson(data);
      if (model.itemData == null || model.itemData!.isEmpty) {
        isSearchLoadMore.value = false;
      } else {
        searchPageIndex.value++;
        searchItems.addAll(model.itemData!);
        model.itemData?.forEach((element) {
          subQty.putIfAbsent(
              '${element.itemCode}-${element.warehouse}', () => 0);
        });
      }
    }
    if(refresh){
      scrollController.jumpTo(0);
    }
    update();
  }

  void setSearch() {
    isSearch.value = isSearch.value ? false : true;
    (isSearch.value == false) ? searchController.value.clear() : null;
    update();
  }

  void searchItemsList(String search) {
    searchPageIndex.value = 0;
    isSearchLoadMore.value = true;

    if (searchValue.compareTo(search) != 0) {
      getItems(itemName: search, isSearching: true);
    }

    update();
  }

  void showList(String search) {
    if (searchController.value.text.trim() == "") {
      update();
    }
  }

  totalItemsCount() {
    totalItems.value = 0;
    subQty.forEach((key, value) {
      totalItems.value += value.toInt();
    });
  }

  // void searchedList(String? searchValue) {
  //   if (searchController.text.isNotEmpty) {
  //     searchItems.clear();
  //     for (var element in firmData) {
  //       List<ItemData> temp = [];
  //       for (var e in element['data']) {
  //         if (e.itemName!.toLowerCase().contains(searchValue!.toLowerCase())) {
  //           temp.add(e);
  //         } else if (e.itemCode!
  //             .toLowerCase()
  //             .contains(searchValue.toLowerCase())) {
  //           temp.add(e);
  //         }
  //       }
  //       if (temp.isNotEmpty) {
  //         searchItems.addAll(temp);
  //       }
  //     }
  //   } else {
  //     searchItems.clear();
  //   }
  //   update();
  // }

  increaseItem1(ItemData data) {
    bool added = true;
    for (var i in selectedItemsList) {
      if (i.itemCode == data.itemCode && i.warehouse == data.warehouse) {
        added = false;
        break;
      }
    }
    added ? selectedItemsList.add(data) : null;
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
