import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/common_widgets/common_item_view.dart';
import 'package:service_call_management/screens/choose_items/choose_item_controller.dart';
import 'package:service_call_management/screens/purchase_order_review/order_review_controller.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

class PurchaseOrderReviewPage extends StatelessWidget {
  PurchaseOrderReviewPage({super.key});
  final reviewController = Get.put(OrderReviewController());
  final ChooseItemController items = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Review'),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.whiteColor,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: colorButton(
                      title: "Add More Items",
                      color: AppColors.blue24Color,
                      onPressed: () {
                        Get.back();
                      }),
                ),
                10.sizedBoxHeight,
                Expanded(
                  child: GetBuilder(
                    init: ChooseItemController(),
                    builder: (items) => ListView.separated(
                        itemBuilder: (context, index) {
                          return CommonItemView(
                            warehouse: items.selectedItemsList[index].warehouse
                                .toString(),
                            groupName: items.selectedItemsList[index].groupName
                                .toString(),
                            title: items.selectedItemsList[index].itemCode
                                .toString(),
                            subTitle: items.selectedItemsList[index].itemName
                                .toString(),
                            increment: () => items
                                .increaseItem1(items.selectedItemsList[index]),
                            decrement: () => items
                                .decreaseItem1(items.selectedItemsList[index]),
                            subQty: items.subQty[
                                        '${items.selectedItemsList[index].itemCode}-${items.selectedItemsList[index].warehouse}']
                                    ?.toInt() ??
                                0,
                            quantity:
                                (items.selectedItemsList[index].quantity ?? 0)
                                    .toInt(),
                            remove: () {
                              items.removeItem(items.selectedItemsList[index]);
                            },
                            //remove: items.removeItem(items.selectedItemsList[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                            color: AppColors.grey848Color,
                          );
                        },
                        itemCount: items.selectedItemsList.length),
                  ),
                ),
                Obx(() => items.selectedItemsList.isNotEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.whiteColor,
                        child: colorButton(
                            title: "Submit",
                            color: AppColors.green33AColor,
                            onPressed: items.toWarehouse.isEmpty
                                ? items.submitForPurchase
                                : items.submitForInventory))
                    : const SizedBox()),
              ],
            ),
          ],
        ));
  }

  Widget colorButton(
      {required String title,
      required Color color,
      required void Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(color: color, width: 1.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.mediumTS.copyWith(color: color, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
