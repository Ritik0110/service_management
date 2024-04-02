import 'package:get/get.dart';
import 'package:service_call_management/repository/models/product_model.dart';

class ChooseItemController extends GetxController {
  RxInt selectedItem = 0.obs;
  RxList selectedItems = [].obs;
  List items = [];
  RxMap selectedItemsList = {}.obs;

  @override
  void onInit() {
    super.onInit();
    items = DataList.itemsList;
    print(items);
    items.forEach((element) {
      for (var i = 0; i < element["subMenu"].length; i++) {
        print("${element["subMenu"][i]["id"]}");
        print("${element["subMenu"][i]["series_number"]}");
        selectedItemsList.addAll({
          "${element["subMenu"][i]["id"]}${element["subMenu"][i]["series_number"]}":
              false
        });
      }
    });
    print(selectedItemsList);
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
