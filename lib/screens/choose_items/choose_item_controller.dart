import 'package:get/get.dart';
import 'package:service_call_management/repository/models/product_model.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_url.dart';

class ChooseItemController extends GetxController {
  RxInt totalItems = 0.obs;
  RxList selectedItems = [].obs;
  RxList items = [].obs;
  final _api = NetWorkApiService();


  @override
  void onInit() {
    super.onInit();
    items.value = DataList.itemsList;
    getItems();
  }

  Future getItems() async {
    var data = await _api.getApi(AppUrl.getItems);
    print(data.toString());

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

  increaseItem(var data) {
    if(selectedItems.contains(data)){
      selectedItems[selectedItems.indexOf(data)]["quantity"] += 1;
    }else{
      selectedItems.add(data);
      selectedItems[selectedItems.indexOf(data)]["quantity"] += 1;
    }
    update();
    print(selectedItems.toString());
  }
  increaseItem1(int mainIndex, int subIndex) {
    items[mainIndex]["subMenu"][subIndex]["quantity"] += 1;
    totalItemsCount();
    print(items[mainIndex]["subMenu"][subIndex]["quantity"]);
    update();
  }
  decreaseItem1(int mainIndex, int subIndex) {
    if (items[mainIndex]["subMenu"][subIndex]["quantity"] > 1) {
      items[mainIndex]["subMenu"][subIndex]["quantity"] -= 1;
      totalItemsCount();
      print(items[mainIndex]["subMenu"][subIndex]["quantity"]);
    }
    update();
  }
  decreaseItem(var data){
    if(selectedItems.contains(data)){
      if(selectedItems[selectedItems.indexOf(data)]["quantity"] > 1){
        selectedItems[selectedItems.indexOf(data)]["quantity"] -= 1;
      }
      else if(selectedItems[selectedItems.indexOf(data)]["quantity"] == 1){
          selectedItems[selectedItems.indexOf(data)]["quantity"] -= 1;
          selectedItems.remove(data);
        }
      update();
      print(selectedItems.toString());
    }
  }
}
