import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/TicketsModel.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_item_view.dart';
import '../purchase_order_review/purhcase_order_review.dart';
import 'choose_item_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_test_style.dart';
import '../../utils/extension/size_extension.dart';

class ChooseItems extends StatefulWidget {
  const ChooseItems({super.key, this.requirementDate, required this.data});
  /*final String fromWarehouse;
  final String? toWarehouse;*/
  final DateTime? requirementDate;
  final ServiceData data;
  @override
  State<ChooseItems> createState() => _ChooseItemsState();
}

class _ChooseItemsState extends State<ChooseItems> {
  final chooseController = Get.put(ChooseItemController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*chooseController.fromWarehouse.value = widget.fromWarehouse;
    chooseController.toWarehouse = widget.toWarehouse ?? "";*/
    chooseController.requireDate = widget.requirementDate;
    chooseController.data = widget.data;
  }

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
            onPressed: chooseController.setSearch,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              chooseController.getFirms();
            },
            icon: const Icon(Icons.sync_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => (chooseController.isSearch.value)
              ? Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.blue2E6Color,
                  ),
                  child: TextField(
                    controller: chooseController.searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: AppColors.whiteColor,
                      filled: true,
                    ),
                    onChanged: chooseController.searchedList,
                    textAlign: TextAlign.start,
                    cursorWidth: 1,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                )
              : Container()),
          /*Expanded(
            child: Obx(() => (chooseController.firmData.isEmpty)
                ? Center(
                    child: Text(
                      "No Items Found",
                      style: AppTextStyle.black323semi16,
                    ),
                  )
                : ListView.separated(
                    itemCount: chooseController.firmData.length,
                    itemBuilder: (context, index) {
                      return (!chooseController.firmData[index]['data'].isEmpty)
                          ? Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              color: Colors.red,
                              child: Text(
                                chooseController.firmData[index]['firmName'],
                                style: AppTextStyle.white16medium,
                              ),
                            )
                          : ExpansionTile(
                              onExpansionChanged: (value) {
                                print("object : - $value");
                               if(value && chooseController.firmData[index]['data'].isEmpty){
                                 chooseController.getItems(
                                     firmName: chooseController.firmData[index]
                                     ['firmName'],
                                     page: chooseController.firmData[index]
                                     ['page'], index: index);
                               }
                              },
                              backgroundColor: AppColors.whiteColor,
                              collapsedBackgroundColor: AppColors.whiteColor,
                              title: Text(
                                chooseController.firmData[index]['firmName']
                                    .toString(),
                                style: AppTextStyle.black323semi14,
                              ),
                              iconColor: AppColors.grey848Color,
                              collapsedIconColor: AppColors.grey848Color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              children: [
                                  chooseController
                                          .firmData[index]['data'].isEmpty
                                      ? Container()
                                      : ListView.separated(
                                          itemCount: chooseController
                                              .firmData[index]['data'].length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, j) {
                                            return GetBuilder(
                                                init: chooseController,
                                                builder: (control) {
                                                  return CommonItemView(
                                                    warehouse: control
                                                        .searchItems[index][j]
                                                        .warehouse
                                                        .toString(),
                                                    groupName: control
                                                        .searchItems[index][j]
                                                        .groupName
                                                        .toString(),
                                                    title: control
                                                        .searchItems[index][j]
                                                        .itemCode
                                                        .toString(),
                                                    subTitle: control
                                                        .searchItems[index][j]
                                                        .itemName
                                                        .toString(),
                                                    quantity: (control
                                                                .searchItems[
                                                                    index][j]
                                                                .quantity ??
                                                            0)
                                                        .toInt(),
                                                    subQty: control.subQty[
                                                                '${control.searchItems[index][j].itemCode}-${control.searchItems[index][j].warehouse}']
                                                            ?.toInt() ??
                                                        0,
                                                    increment: () =>
                                                        chooseController
                                                            .increaseItem1(control
                                                                    .searchItems[
                                                                index][j]),
                                                    decrement: () =>
                                                        chooseController
                                                            .decreaseItem1(control
                                                                    .searchItems[
                                                                index][j]),
                                                  );
                                                });
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Divider(
                                                color: AppColors.grey848Color
                                                    .withOpacity(0.5),
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
          ),*/
          Expanded(
            child: GetBuilder(
              init: ChooseItemController(),
              builder: (control) {
                if (control.searchController.text != "") {
                  print("Hello from in loop");
                  if(control.searchItems.isEmpty){
                    return Center(
                      child: Text(
                        "No Items Found",
                        style: AppTextStyle.black323semi16,
                      ),
                    );
                  }else{
                    return ListView.separated(
                      itemCount: control.searchItems.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, j){
                        return CommonItemView(
                          warehouse:
                          control.searchItems[j].warehouse.toString(),
                          groupName:
                          control.searchItems[j].groupName.toString(),
                          title: control.searchItems[j].itemCode.toString(),
                          subTitle: control.searchItems[j].itemName.toString(),
                          quantity:
                          (control.searchItems[j].quantity ?? 0).toInt(),
                          subQty: control.subQty[
                          '${control.searchItems[j].itemCode}-${control.searchItems[j].warehouse}']
                              ?.toInt() ??
                              0,
                          increment: () =>
                              control.increaseItem1(control.searchItems[j]),
                          decrement: () =>
                              control.decreaseItem1(control.searchItems[j]),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            color: AppColors.grey848Color.withOpacity(0.5),
                            height: 1,
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return ListView.separated(
                    itemCount: control.firmData.length,
                    itemBuilder: (context, index) {
                      if (control.firmData.isEmpty) {
                        return Center(
                          child: Text(
                            "No Items Found",
                            style: AppTextStyle.black323semi16,
                          ),
                        );
                      } else {
                        return ExpansionTile(
                          backgroundColor: AppColors.whiteColor,
                          collapsedBackgroundColor: AppColors.whiteColor,
                          title: Text(
                            control.firmData[index]['firmName'].toString(),
                            style: AppTextStyle.black323semi14,
                          ),
                          iconColor: AppColors.grey848Color,
                          collapsedIconColor: AppColors.grey848Color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          children: [
                            (control.firmData[index]['data'].isEmpty)
                                ? Container()
                                : SizedBox(
                                    height: 300,
                                    child: ListView.separated(
                                      controller: control.firmData[index]
                                          ['scroll'],
                                      itemCount: control
                                          .firmData[index]['data'].length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, j) {
                                        if (control.firmData[index]['data']
                                                .length ==
                                            0) {
                                          return Container();
                                        } else {
                                          return CommonItemView(
                                            warehouse: control
                                                .firmData[index]['data'][j]
                                                .warehouse
                                                .toString(),
                                            groupName: control
                                                .firmData[index]['data'][j]
                                                .groupName
                                                .toString(),
                                            title: control
                                                .firmData[index]['data'][j]
                                                .itemCode
                                                .toString(),
                                            subTitle: control
                                                .firmData[index]['data'][j]
                                                .itemName
                                                .toString(),
                                            quantity: (control
                                                        .firmData[index]['data']
                                                            [j]
                                                        .quantity ??
                                                    0)
                                                .toInt(),
                                            subQty: control.subQty[
                                                        '${control.firmData[index]['data'][j].itemCode}-${control.firmData[index]['data'][j].warehouse}']
                                                    ?.toInt() ??
                                                0,
                                            increment: () =>
                                                chooseController.increaseItem1(
                                                    control.firmData[index]
                                                        ['data'][j]),
                                            decrement: () =>
                                                chooseController.decreaseItem1(
                                                    control.firmData[index]
                                                        ['data'][j]),
                                          );
                                        }
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Divider(
                                            color: AppColors.grey848Color
                                                .withOpacity(0.5),
                                            height: 1,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return 4.sizedBoxHeight;
                    },
                  );
                }
              },
            ),
          ),
          Obx(() => Container(
                padding: const EdgeInsets.only(left: 14),
                width: MediaQuery.of(context).size.width,
                color: AppColors.whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Items: (${chooseController.totalItems.value})",
                      style: AppTextStyle.black191medium16,
                    ),
                    CommonMaterialButton(
                      enable:
                          chooseController.totalItems.value > 0 ? true : false,
                      buttonText: "Review",
                      onTap: () {
                        Get.to(() => PurchaseOrderReviewPage());
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
