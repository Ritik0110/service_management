import 'package:get/get.dart';
import 'package:service_call_management/Models/ItemModel.dart';
import 'package:service_call_management/repository/models/product_model.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_url.dart';

class ChooseItemController extends GetxController {
  RxInt totalItems = 0.obs;
  RxList selectedItems = [].obs;
  RxList items = [].obs;
  final _api = NetWorkApiService();
  ItemModel model = ItemModel();
  var subLists =  <String, List<ItemData>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    items.value = DataList.itemsList;
    getItems();
  }

  Future getItems() async {
    var data = await _api.postApi(AppUrl.getItems,{
      "WhsCode": "02",
    });
    model = ItemModel.fromJson(data);
    model.itemData?.forEach((element) {
      if (!subLists.containsKey(element.groupName)) {
        subLists[element.groupName.toString()] = [];
      }
      subLists[element.groupName]!.add(element);
    });
    print(subLists["Finish Goods"]?[0].itemName);




  }
  totalItemsCount() {
    totalItems.value = 0;
    for (int i = 0; i < items.length; i++) {
      for (int j = 0; j < items[i]["subMenu"].length; j++) {
        totalItems += items[i]["subMenu"][j]["quantity"];
      }
    }
    print(totalItems.value);
  }

  increaseItem1(int mainIndex, int subIndex) {
    items[mainIndex]["subMenu"][subIndex]["quantity"] += 1;
    totalItemsCount();
    print(items[mainIndex]["subMenu"][subIndex]["quantity"]);
    update();
  }
  decreaseItem1(int mainIndex, int subIndex) {
    if (items[mainIndex]["subMenu"][subIndex]["quantity"] >= 1) {
      items[mainIndex]["subMenu"][subIndex]["quantity"] -= 1;
      totalItemsCount();
      print(items[mainIndex]["subMenu"][subIndex]["quantity"]);
    }
    update();
  }
}
