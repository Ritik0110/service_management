import 'package:flutter/material.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

class PurchaseRequest extends StatefulWidget {
  const PurchaseRequest({super.key});

  @override
  State<PurchaseRequest> createState() => _PurchaseRequestState();
}

class _PurchaseRequestState extends State<PurchaseRequest> {
  String dropdownValue = 'All';
  var requestTypes = ['All', 'Open', 'Close'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Request'),
      ),
      body: Stack(
        children: [
          Container(
            height: 50,
            color: AppColors.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Purchase Request",
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
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              itemCount: 10,
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
                          Text("\$12,000", style: AppTextStyle.black191medium16),
                        ],
                      )
                    ],
                  ),
                );
              },
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
      text: TextSpan(
          text: title,
          style: reversed ? style : AppTextStyle.grey84regular16,
          children: [
            TextSpan(
                text: value, style: reversed ? AppTextStyle.grey84regular16 : style)
          ]),
    );
  }
}