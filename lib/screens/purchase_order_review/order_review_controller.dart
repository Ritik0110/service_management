import 'package:get/get.dart';
import 'package:service_call_management/screens/choose_items/choose_item_controller.dart';

class OrderReviewController extends GetxController {
  RxInt totalAmount = 0.obs;
  final ChooseItemController itemControl = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateTotalAmount();
  }

  void updateTotalAmount() {
    totalAmount.value = 0;

    for (var i = 0; i < itemControl.selectedItems.length; i++) {
      totalAmount = totalAmount + itemControl.selectedItems[i]["total_price"];
    }
    update();
  }

  void removeItem(index) {
    totalAmount.value = 0;
    print(index);
    itemControl.itemSelected(itemControl.selectedItems[index],
        "${itemControl.selectedItems[index]["id"]}${itemControl.selectedItems[index]["series_number"]}");
    updateTotalAmount();
  }

  void increaseQuantity(index) {
    totalAmount.value = 0;
    itemControl.selectedItems[index]["selected_items"] += 1;
    itemControl.selectedItems[index]["total_price"] =
        itemControl.selectedItems[index]["selected_items"] *
            itemControl.selectedItems[index]["price"];
    updateTotalAmount();
  }

  void decreaseQuantity(index) {
    totalAmount.value = 0;
    itemControl.selectedItems[index]["selected_items"] -= 1;
    itemControl.selectedItems[index]["total_price"] =
        itemControl.selectedItems[index]["selected_items"] *
            itemControl.selectedItems[index]["price"];

    updateTotalAmount();
  }
}
