import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/common_widgets/common_button.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

import '../purchase_request_form/purchase_request_form.dart';

class StockRequest extends StatefulWidget {
  const StockRequest({super.key});

  @override
  State<StockRequest> createState() => _StockRequestState();
}

class _StockRequestState extends State<StockRequest>
    with SingleTickerProviderStateMixin {
  String dropdownValue = 'All';
  var requestTypes = ['All', 'Open', 'Close'];
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Request'),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xff1B4EBB),
            child: TabBar(
                controller: tabController,
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
            child: TabBarView(
                controller: tabController,
                children: [
              _commonListView(filterText: "Purchase Request"),
              _commonListView(filterText: "Transfer Request")
            ]),
          ),
          CommonMaterialButton(
              buttonText: tabController?.index == 0
                  ? "New Purchase Request"
                  : "New Transfer Request",
              onTap: () {
                Get.to(() => PurchaseRequestForm());
              })
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

  Widget _commonListView({required String filterText}) {
    return Column(
      children: [
        _filterWidget(headerText: filterText),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "#40551$index",
                          style: AppTextStyle.grey646semi16,
                        ),
                        commonRow(
                            title: "Status : ",
                            value: " Open",
                            style: AppTextStyle.green47cSemi16)
                      ],
                    ),
                    10.sizedBoxHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonRow(
                            title: "Microchips ",
                            value: "\n21-March-2024",
                            style: AppTextStyle.black191medium16,
                            reversed: true),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _filterWidget({
    required String headerText,
  }) {
    return Container(
      height: 50,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerText,
            style: AppTextStyle.grey84regular16,
          ),
          DropdownButton(
              style: AppTextStyle.green47cSemi16,
              value: dropdownValue,
              items: requestTypes.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: item == "All"
                        ? AppTextStyle.blue2f6Semi16
                        : item == "Open"
                            ? AppTextStyle.green47cSemi16
                            : AppTextStyle.redFF5Semi16,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value.toString();
                });
              })
        ],
      ),
    );
  }
}