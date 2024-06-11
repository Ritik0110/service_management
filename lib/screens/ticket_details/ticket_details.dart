import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/common_widgets/common_button.dart';
import 'package:service_call_management/screens/stock_request/stock_request.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ticket_details_controller.dart';

class TicketDetails extends StatefulWidget {
  const TicketDetails(
      {super.key,
      required this.ticketId,
      required this.ticketTitle,
      required this.ticketTime,
      required this.ticketStatus,
      required this.ticketLocation,
      required this.ticketPriority,
      required this.customerName,
      required this.contactPerson,
      required this.startDate,
      required this.endDate,
      required this.model,
      required this.manuSN,
      required this.contactNumber,
      required this.subStatus});
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
  final String subStatus;
  final String model;
  final String manuSN;

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  final ticketController = Get.put(TicketDetailsController());

  @override
  void initState() {
    super.initState();
    ticketController.selectedSubStatus.value = widget.subStatus;
    ticketController.callId.value = widget.ticketId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          title: const Text('Ticket Details'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              padding: const EdgeInsets.only(left: 16, right: 16,top: 16, bottom: 0),
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#${widget.ticketId}",
                    style: AppTextStyle.grey646semi16,
                  ),
                  Text(
                    "${widget.ticketTitle}",
                    style: AppTextStyle.black191medium16,
                  ),
                  5.sizedBoxHeight,
                  commonRow(
                      title: "Duration : ",
                      value: "${widget.ticketTime}",
                      style: AppTextStyle.black323semi16),
                  5.sizedBoxHeight,
                  commonRow(
                      title: "Status : ",
                      value: "${widget.ticketStatus}",
                      style: AppTextStyle.green47cSemi16),
                  5.sizedBoxHeight,
                  commonRow(
                      title: "Model : ",
                      value: "${widget.model}",
                      style: AppTextStyle.black323semi16),
                  5.sizedBoxHeight,
                  commonRow(
                      title: "ManuSN : ",
                      value: "${widget.manuSN}",
                      style: AppTextStyle.black323semi16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonRow(
                        title: "subStatus : ",
                        value: "${widget.subStatus}",
                        style: AppTextStyle.semiBoldTS.copyWith(
                            color: AppColors.black323Color, fontSize: 16),
                      ),

                      MaterialButton(
                        onPressed: ticketController.changeStatus,
                        height: 25,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        color: AppColors.grey7A7Color.withOpacity(0.25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: AppColors.grey848Color),
                        ),
                        child: Text(
                          "Change",
                          style: AppTextStyle.black323semi14,
                        ),
                      )
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonRow(
                          title: "Customer Name",
                          value: "\n${widget.customerName}",
                          style: AppTextStyle.black323semi16),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse("tel:${widget.contactNumber}"));
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
                      title: "Phone",
                      value: "\n${widget.contactNumber}",
                      style: AppTextStyle.black323semi16),
                  10.sizedBoxHeight,
                  commonRow(
                      title: "Address",
                      value: "\n${widget.ticketLocation}",
                      style: AppTextStyle.black323semi16),
                  10.sizedBoxHeight,
                  commonRow(
                      title: "Start Date",
                      value: "\n${widget.startDate}",
                      style: AppTextStyle.black323semi16),
                  10.sizedBoxHeight,
                  commonRow(
                      title: "Remarks :",
                      value: "\n${widget.ticketLocation}",
                      style: AppTextStyle.black323semi16),
                ],
              ),
            ),
            const Spacer(),
            CommonMaterialButton(
                buttonText: "Stock Request",
                onTap: () {
                  Get.to(() => StockRequest(
                        callId: widget.ticketId,
                      ));
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
