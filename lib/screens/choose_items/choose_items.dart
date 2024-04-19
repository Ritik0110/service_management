import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_item_view.dart';
import '../purchase_order_review/purhcase_order_review.dart';
import 'choose_item_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_test_style.dart';
import '../../utils/extension/size_extension.dart';

class ChooseItems extends StatelessWidget {
  ChooseItems({super.key,required this.warehouse});
  String warehouse;
  final chooseController = Get.put(ChooseItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Items'),
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.delete<ChooseItemController>();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sync_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.separated(
                  itemCount: chooseController.groupItems.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                        backgroundColor: AppColors.whiteColor,
                        collapsedBackgroundColor: AppColors.whiteColor,
                        title: Text(
                          chooseController.groupItems[index][0].groupName
                              .toString(),
                          style: AppTextStyle.black323semi14,
                        ),
                        iconColor: AppColors.grey848Color,
                        collapsedIconColor: AppColors.grey848Color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        children: [
                          ListView.separated(
                            itemCount:
                                chooseController.groupItems[index].length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, j) {
                              return GetBuilder(
                                  init: chooseController,
                                  builder: (control) {
                                    return CommonItemView(
                                      title: control
                                          .groupItems[index][j].itemCode
                                          .toString(),
                                      subTitle: control
                                          .groupItems[index][j].itemName
                                          .toString(),
                                      quantity: (control.groupItems[index][j]
                                                  .quantity ??
                                              0)
                                          .toInt(),
                                      subQty: control.subQty[control
                                          .groupItems[index][j].itemCode
                                          .toString()]?.toInt() ?? 0,
                                      increment: () =>
                                          chooseController.increaseItem1(control
                                              .groupItems[index][j]),
                                      decrement: () =>
                                          chooseController.decreaseItem1(control
                                              .groupItems[index][j]),
                                    );
                                  });
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Divider(
                                  color:
                                      AppColors.grey848Color.withOpacity(0.5),
                                  height: 1,
                                ),
                              );
                            },
                          )
                        ]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 2.sizedBoxHeight;
                  },
                )),
          ),
          Container(
            padding: const EdgeInsets.only(left: 14),
            width: MediaQuery.of(context).size.width,
            color: AppColors.whiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                      "Total Items: (${chooseController.totalItems.value})",
                      style: AppTextStyle.black191medium16,
                    )),
                CommonMaterialButton(
                  buttonText: "Review Order",
                  onTap: () {
                    Get.to(PurchaseOrderReviewPage());
                  },
                  width: 200,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget commonRow(
      {required String title,
      required String value,
      required TextStyle style,
      bool reversed = false}) {
    return RichText(
      maxLines: 3,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      text: TextSpan(
          text: title,
          style: reversed ? style : AppTextStyle.grey84regular16,
          children: [
            TextSpan(
                text: value,
                style: reversed ? AppTextStyle.grey84regular16 : style)
          ]),
    );
  }
}
