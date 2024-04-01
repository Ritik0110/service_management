import 'package:get/get.dart';
import 'package:service_call_management/repository/models/product_model.dart';

class ChooseItemController extends GetxController{
  RxInt selectedItem = 0.obs;
  RxList selectedItems = [].obs;
  List items =[];


  @override
  void onInit() {
    super.onInit();
    items = DataList.itemsList;
    print(items);
  }

  itemSelected(var data){
    if(selectedItems.contains(data)){
      selectedItems.remove(data);
    }else{
      selectedItems.add(data);
    }
    selectedItem.value = selectedItems.length;
  }
}