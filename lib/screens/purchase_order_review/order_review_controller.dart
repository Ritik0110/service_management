import 'package:get/get.dart';
import 'package:service_call_management/screens/choose_items/choose_item_controller.dart';

class OrderReviewController extends GetxController {
  final ChooseItemController itemControl = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }




  void increaseQuantity(index) {
    itemControl.selectedItems[index]["selected_items"] += 1;
    update(["quantity"]);
  }

  void decreaseQuantity(index) {
    if (itemControl.selectedItems[index]["selected_items"] > 1) {
      itemControl.selectedItems[index]["selected_items"] -= 1;
    }
  }
}
