import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_item_view.dart';
import 'choose_item_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_test_style.dart';
import '../../utils/extension/size_extension.dart';

class ChooseItems extends StatelessWidget {
  ChooseItems({super.key});

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
            child: ListView.builder(
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, j) {
                              return GetBuilder(
                                  init: chooseController,
                                  builder: (control) {
                                    return CommonItemView(
                                        title: chooseController.items[index]
                                            ["subMenu"][j]["name"],
                                        subTitle: chooseController.items[index]
                                            ["subMenu"][j]["series_number"],
                                        quantity: chooseController.items[index]
                                            ["subMenu"][j]["quantity"],
                                        increment: () => chooseController
                                            .increaseItem1(index, j),
                                        decrement: () => chooseController
                                            .decreaseItem1(index, j),
                                        imageUrl: "imageUrl");
                                  });
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 14),
                                color: AppColors.scaffoldColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
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
                                            style: AppTextStyle.black323semi14,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            chooseController.items[index]
                                                ["subMenu"][j]["series_number"],
                                            style: AppTextStyle.grey7A7medium14,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.grey848Color,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () => chooseController
                                                .decreaseItem1(index, j),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 20,
                                              color: AppColors.grey848Color,
                                            ),
                                          ),
                                          const VerticalDivider(
                                            color: AppColors.grey848Color,
                                            thickness: 1,
                                          ),
                                          GetBuilder(
                                              init: chooseController,
                                              builder: (control) {
                                                return Text(
                                                    "${control.items[index]["subMenu"][j]["quantity"]}",
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: AppTextStyle
                                                        .black323medium14);
                                              }),
                                          const VerticalDivider(
                                            color: AppColors.grey848Color,
                                            thickness: 1,
                                          ),
                                          InkWell(
                                            onTap: () => chooseController
                                                .increaseItem1(index, j),
                                            child: const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: AppColors.grey848Color,
                                            ),
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             PurchaseOrderReviewPage()));
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
