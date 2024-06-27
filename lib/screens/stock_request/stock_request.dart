import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/inventory_model.dart';
import 'package:service_call_management/common_widgets/common_button.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

import '../purchase_request_form/purchase_request_form.dart';
import 'stock_request_controller.dart';

class StockRequest extends StatefulWidget {
  const StockRequest({super.key, required this.callId});

  final String callId;
  @override
  State<StockRequest> createState() => _StockRequestState();
}

class _StockRequestState extends State<StockRequest>
    with SingleTickerProviderStateMixin {
  final StockController stockControl = Get.put(StockController());

  @override
  void initState() {
    stockControl.callId.value = widget.callId;
    stockControl.headerTab = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parts Request'),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xff1B4EBB),
            child: TabBar(
                onTap: (index) {
                  stockControl.changeIndex(index);
                },
                controller: stockControl.headerTab,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.green33AColor,
                indicatorWeight: 5,
                padding: EdgeInsets.zero,
                unselectedLabelStyle: AppTextStyle.grey7A7semi14,
                labelStyle: AppTextStyle.white14semiBold,
                tabs: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    child: const Tab(
                      child: Text("Purchase Request"),
                    ),
                  ),
                  const Tab(
                    child: Text(
                      "Transfer Request",
                    ),
                  ),
                ]),
          ),
          Expanded(
              child: Obx(
            () => TabBarView(
                controller: stockControl.headerTab,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _commonListView(
                      filterText: "Purchase Request",
                      list: stockControl.subProductList),
                  _commonListView(
                      filterText: "Transfer Request",
                      list: stockControl.subTransferList)
                ]),
          )),
          CommonMaterialButton(
              buttonText: "New Part Requests?",
              onTap: () {
                Get.to(() => PurchaseRequestForm(
                      isPurchase: true,
                      callId: widget.callId,
                    ));
              })
        ],
      ),
    );
  }

  Widget commonRow(
      {required String title,
      required String value,
      required TextStyle style,
        int maxLine = 1,
      bool reversed = false}) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
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

  Widget _commonListView(
      {required String filterText, required List<Data> list}) {
    return Column(
      children: [
        // _filterWidget(headerText: filterText, count: list.length),
        Expanded(
          child: list.isEmpty
              ? Center(
                  child: Text(
                  "No Data Found",
                  style: AppTextStyle.black323semi16,
                ))
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return commonCard(listItem: list[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _filterWidget({required String headerText, required int count}) {
    return Container(
      height: 50,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          commonRow(
              title: headerText,
              value: " ($count)",
              style: AppTextStyle.black323regular16),
          const Spacer(),
          Text(
            "Status : ",
            style: AppTextStyle.grey84regular16,
          ),
          DropdownButton(
            style: AppTextStyle.green47cSemi16,
            value: stockControl.dropdownValue.value,
            items: stockControl.requestTypes.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: item == "All"
                      ? AppTextStyle.blue2f6Semi16
                      : item == "Open"
                          ? AppTextStyle.purple9C5Semi16
                          : AppTextStyle.redFF5Semi16,
                ),
              );
            }).toList(),
            onChanged: stockControl.changeDropDownValue,
          )
        ],
      ),
    );
  }

  commonCard({required Data listItem}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: AppColors.grey646Color.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonRow(
                  title: "Doc no: ",
                  value: "${listItem.docNum}",
                  style: AppTextStyle.black323semi16),
              const Spacer(),
              Expanded(
                flex: 4,
                child: commonRow(
                    title: "Posting Date :",
                    value: "${listItem.docDate}",
                    style: AppTextStyle.black323semi16),
              ),

              /*commonRow(
                  title: "Status : ",
                  value: list[index].docStatus,
                  style: list[index].docStatus == "All"
                      ? AppTextStyle.blue2f6Semi16
                      : list[index].docStatus == "Open"
                          ? AppTextStyle.purple9C5Semi16
                          : AppTextStyle.redFF5Semi16)*/
            ],
          ),
          10.sizedBoxHeight,
          commonRow(
              title: "Required Date: ",
              value: " ${listItem.reqDate}",
              style: AppTextStyle.black323semi16),
          10.sizedBoxHeight,
          ListView.separated(
              separatorBuilder: (context, index) => 5.sizedBoxHeight,
              shrinkWrap: true,
              itemCount: listItem.itemData?.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if(listItem.itemData!.isEmpty){
                  return Container();
                }else{
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: commonRow(
                          maxLine: 3,
                            title: listItem.itemData?[index].itemCode ?? "",
                            value: "\n${listItem.itemData?[index].description}",
                            style: AppTextStyle.black323medium14),
                      ),
                      20.sizedBoxWidth,
                      Text(
                        "${listItem.itemData?[index].quantity}",
                        style: AppTextStyle.black323medium14,
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
