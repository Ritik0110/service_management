import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/choose_items/choose_item_controller.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

import '../../common_widgets/common_button.dart';
import 'order_review_controller.dart';

class PurchaseOrderReviewPage extends StatelessWidget {
  PurchaseOrderReviewPage({super.key});

  final reviewController = Get.put(OrderReviewController());

  final ChooseItemController itemsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Purchase Order Review'),
          leading: IconButton(
            onPressed: () {
              Get.back();
              Get.delete<OrderReviewController>();
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
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text("Change Warehouse",
                            style: AppTextStyle.yellowFF9regular16),
                      ),
                      colorButton(
                          "Add More Items", AppColors.blue24Color, () {}),
                    ],
                  ),
                ),
                10.sizedBoxHeight,
                Expanded(
                  child: Container(
                    color: AppColors.whiteColor,
                    child: GetBuilder(
                      id: "order_review",
                      init: OrderReviewController(),
                      builder: (control) {
                        return ListView.builder(
                            itemCount: itemsController.selectedItems.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              "https://4.imimg.com/data4/GL/UP/MY-5812789/3-printer.jpg",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                        10.sizedBoxWidth,
                                        commonRow(
                                            title: itemsController
                                                    .selectedItems[index]
                                                ["series_number"],
                                            value:
                                                "\n${itemsController.selectedItems[index]["name"]}",
                                            style:
                                                AppTextStyle.black323medium14),
                                        const Spacer(),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "Unit Price : \$${itemsController.selectedItems[index]["price"]}",
                                                style: AppTextStyle
                                                    .grey84regular14),
                                            Text(
                                                "Total: \$${itemsController.selectedItems[index]["total_price"]}",
                                                style: AppTextStyle
                                                    .black323medium14)
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                          },
                                          child: Row(
                                            children: [
                                              Text("remove",
                                                  style: AppTextStyle
                                                      .grey84regular14),
                                              const Icon(
                                                Icons.delete_outline_outlined,
                                                color: AppColors.grey848Color,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.grey848Color,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  control
                                                      .decreaseQuantity(index);
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: AppColors.grey848Color,
                                                ),
                                              ),
                                              const VerticalDivider(
                                                color: AppColors.grey848Color,
                                                thickness: 1,
                                              ),
                                              Text(
                                                  itemsController
                                                      .selectedItems[index]
                                                          ["selected_items"]
                                                      .toString(),
                                                  style: AppTextStyle
                                                      .black323medium14),
                                              const VerticalDivider(
                                                color: AppColors.grey848Color,
                                                thickness: 1,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  control
                                                      .increaseQuantity(index);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: AppColors.grey848Color,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.whiteColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => RichText(
                              text: TextSpan(
                                  text: "Total :",
                                  style: AppTextStyle.grey7A7medium16,
                                  children: [
                                TextSpan(
                                  text: "\$ ",
                                  style: AppTextStyle.black323semi16,
                                )
                              ]))),
                      CommonMaterialButton(
                        buttonText: "Submit",
                        onTap: () {},
                        width: 200,
                      )
                    ],
                  ),
                )),
          ],
        ));
  }

  Widget commonRow(
      {required String title,
      required String value,
      required TextStyle style,
      bool reversed = false}) {
    return RichText(
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

  Widget colorButton(String title, Color color, void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
