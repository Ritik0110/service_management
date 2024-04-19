import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/common_widgets/common_button.dart';
import 'package:service_call_management/screens/stock_request/stock_request.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({super.key, required this.ticketId, required this.ticketTitle, required this.ticketTime, required this.ticketStatus,  required this.ticketLocation, required this.ticketPriority, required this.customerName, required this.contactPerson, required this.startDate, required this.endDate, required this.contactNumber});
  final String ticketId;
  final String ticketTitle;
  final String ticketTime;
  final String ticketStatus;
  final String ticketLocation;
  final String ticketPriority;
  final String customerName;
  final String contactPerson;
  final String contactNumber;
  final String startDate;
  final String endDate;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          title: const Text('Ticket Details'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#$ticketId",
                    style: AppTextStyle.grey646semi16,
                  ),
                  Text(
                    "$ticketTitle",
                    style: AppTextStyle.black191medium16,
                  ),
                  10.sizedBoxHeight,
                  commonRow(
                      title: "Time : ",
                      value: "$ticketTime",
                      style: AppTextStyle.black323semi16),
                  commonRow(
                      title: "Status : ",
                      value: "$ticketStatus",
                      style: AppTextStyle.green47cSemi16),
                  commonRow(
                      title: "Priority : ",
                      value: "$ticketPriority",
                      style: AppTextStyle.yellowFF9Semi16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.black191Color,
                      ),
                      Text(
                        "$ticketLocation",
                        style: AppTextStyle.black191medium16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              color: AppColors.whiteColor,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonRow(
                            title: "Customer Name",
                            value: "\n$customerName",
                            style: AppTextStyle.black323semi16),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse("tel:${contactNumber??""}"));
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.whiteF2FColor,
                            child: Icon(
                              Icons.call,
                              color: AppColors.green33AColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    10.sizedBoxHeight,
                    commonRow(
                        title: "Contact Person",
                        value: "\n$contactPerson",
                        style: AppTextStyle.black323semi16),
                    10.sizedBoxHeight,
                    commonRow(
                        title: "Start Date",
                        value: "\n$startDate",
                        style: AppTextStyle.black323semi16),
                    10.sizedBoxHeight,
                    commonRow(
                        title: "End Date",
                        value: "\n$endDate",
                        style: AppTextStyle.black323semi16),
                    24.sizedBoxHeight,
                    CommonMaterialButton(
                        buttonText: "Close Ticket", onTap: () {}),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CommonMaterialButton(
                buttonText: "Stock Request", onTap: () {
                  Get.to(() => StockRequest(callId: ticketId,));
            }),
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
