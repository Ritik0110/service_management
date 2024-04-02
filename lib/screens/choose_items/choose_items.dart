import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/common_widgets/common_button.dart';
import 'package:service_call_management/screens/choose_items/choose_item_controller.dart';
import 'package:service_call_management/screens/purchase_order_review/purhcase_order_review.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

class ChooseItems extends StatelessWidget {
  ChooseItems({super.key});

  final chooseController = Get.put(ChooseItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Items'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sync_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: chooseController.items.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                    title: Text(
                      chooseController.items[index]["productType"],
                      style: AppTextStyle.black323semi14,
                    ),
                    children: [
                      ListView.builder(
                          itemCount:
                              chooseController.items[index]["subMenu"].length,
                          shrinkWrap: true,
                          itemBuilder: (context, j) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              color: AppColors.scaffoldColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value: chooseController
                                                .selectedItemsList[
                                            "${chooseController.items[index]["subMenu"][j]["id"]}${chooseController.items[index]["subMenu"][j]["series_number"]}"],
                                        onChanged: (value) {
                                          chooseController.itemSelected(
                                              chooseController.items[index]
                                                  ["subMenu"][j],
                                              "${chooseController.items[index]["subMenu"][j]["id"]}${chooseController.items[index]["subMenu"][j]["series_number"]}");
                                        }),
                                  ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        "https://4.imimg.com/data4/GL/UP/MY-5812789/3-printer.jpg",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  10.sizedBoxWidth,
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          chooseController.items[index]
                                              ["subMenu"][j]["name"],
                                          softWrap: true,
                                          style: AppTextStyle.black323medium14,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "\$ ${chooseController.items[index]["subMenu"][j]["price"]}",
                                          style: AppTextStyle.black323semi16,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          chooseController.items[index]
                                              ["subMenu"][j]["series_number"],
                                          style: AppTextStyle.grey84regular14,
                                        ),
                                        Text(
                                          chooseController.items[index]
                                                  ["subMenu"][j]["quantity"]
                                              .toString(),
                                          style: AppTextStyle.grey84regular14,
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.sizedBoxWidth
                                ],
                              ),
                            );
                          })
                    ]);
              }),
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
                                text: "${chooseController.selectedItem.value}",
                                style: AppTextStyle.black323semi16,
                                children: [
                              TextSpan(
                                text: "Items Selected",
                                style: AppTextStyle.grey7A7medium16,
                              )
                            ]))),
                    CommonMaterialButton(
                      buttonText: "Review Order",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PurchaseOrderReviewPage()));
                      },
                      width: 200,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
