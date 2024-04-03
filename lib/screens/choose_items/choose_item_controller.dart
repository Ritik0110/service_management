import 'package:get/get.dart';
import 'package:service_call_management/repository/models/product_model.dart';
import 'package:service_call_management/services/network_api_services.dart';
import 'package:service_call_management/utils/app_url.dart';

class ChooseItemController extends GetxController {
  RxInt selectedItem = 0.obs;
  RxList selectedItems = [].obs;
  List items = [];
  RxMap selectedItemsList = {}.obs;
  final _api = NetWorkApiService();



  @override
  void onInit() {
    super.onInit();
    items = DataList.itemsList;
    getItems();
    for (var element in items) {
      for (var i = 0; i < element["subMenu"].length; i++) {
        selectedItemsList.addAll({
          "${element["subMenu"][i]["id"]}${element["subMenu"][i]["series_number"]}":
              false
        });
      }
    }
  }

  Future getItems() async {
    var data = await _api.getApi(AppUrl.getItems);
    print(data.toString());

  }
  itemSelected(var data, var index) {
    if (selectedItems.contains(data)) {
      selectedItemsList["$index"] = false;
      selectedItems.remove(data);
    } else {
      selectedItemsList["$index"] = true;
      selectedItems.add(data);
    }
    selectedItem.value = selectedItems.length;
    update();
  }
}
