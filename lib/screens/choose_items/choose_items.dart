import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/TicketsModel.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_item_view.dart';
import '../purchase_order_review/purhcase_order_review.dart';
import 'choose_item_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_test_style.dart';

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
    chooseController.scrollController.addListener(() {
      if (chooseController.scrollController.position.pixels ==
          chooseController.scrollController.position.maxScrollExtent) {
        chooseController.mainPageIndex.value++;
        chooseController.getItems(
            isSearching: chooseController.isSearch.value,
            itemName: chooseController.searchController.value.text);
      }
    });
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
                chooseController.getItems(refresh: true);
              },
              icon: const Icon(Icons.sync_rounded),
            ),
          ],
        ),
        body: GetBuilder(
            init: ChooseItemController(),
            builder: (control) {
              return Column(
                children: [
                  (control.isSearch.value)
                      ? Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: const BoxDecoration(
                            color: AppColors.blue2E6Color,
                          ),
                          child: TextFormField(
                            controller: control.searchController.value,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fillColor: AppColors.whiteColor,
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  control.searchItemsList(
                                      control.searchController.value.text);
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ),
                            onChanged: chooseController.showList,
                            textAlign: TextAlign.start,
                            cursorWidth: 1,
                            //onChanged: control.searchItemsList,
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: SizedBox(
                      child: (control.searchController.value.text != "")
                          ? (control.searchItems.isEmpty)
                              ? Center(
                                  child: Text(
                                    "No Items Found",
                                    style: AppTextStyle.black323semi16,
                                  ),
                                )
                              : ListView.separated(
                                  controller: control.scrollController,
                                  itemCount: control.searchItems.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, j) {
                                    return CommonItemView(
                                      warehouse: control
                                          .searchItems[j].warehouse
                                          .toString(),
                                      groupName: control
                                          .searchItems[j].groupName
                                          .toString(),
                                      title: control.searchItems[j].itemCode
                                          .toString(),
                                      subTitle: control.searchItems[j].itemName
                                          .toString(),
                                      quantity:
                                          (control.searchItems[j].quantity ?? 0)
                                              .toInt(),
                                      subQty: control.subQty[
                                                  '${control.searchItems[j].itemCode}-${control.searchItems[j].warehouse}']
                                              ?.toInt() ??
                                          0,
                                      increment: () => control.increaseItem1(
                                          control.searchItems[j]),
                                      decrement: () => control.decreaseItem1(
                                          control.searchItems[j]),
                                    );
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
                                )
                          : ListView.separated(
                              controller: control.scrollController,
                              itemCount: control.itemsList.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, j) {
                                return CommonItemView(
                                  warehouse:
                                      control.itemsList[j].warehouse.toString(),
                                  groupName:
                                      control.itemsList[j].groupName.toString(),
                                  title:
                                      control.itemsList[j].itemCode.toString(),
                                  subTitle:
                                      control.itemsList[j].itemName.toString(),
                                  quantity: (control.itemsList[j].quantity ?? 0)
                                      .toInt(),
                                  subQty: control.subQty[
                                              '${control.itemsList[j].itemCode}-${control.itemsList[j].warehouse}']
                                          ?.toInt() ??
                                      0,
                                  increment: () => chooseController
                                      .increaseItem1(control.itemsList[j]),
                                  decrement: () => chooseController
                                      .decreaseItem1(control.itemsList[j]),
                                );
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
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 14),
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.whiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Items: (${control.totalItems.value})",
                          style: AppTextStyle.black191medium16,
                        ),
                        CommonMaterialButton(
                          enable: control.totalItems.value > 0 ? true : false,
                          buttonText: "Review",
                          onTap: () {
                            Get.to(() => PurchaseOrderReviewPage());
                          },
                          width: 200,
                        )
                      ],
                    ),
                  ),
                ],
              );
            }));
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
