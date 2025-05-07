import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/TicketsModel.dart';
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
      required this.data,
      });
  final ServiceData data;

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  final ticketController = Get.put(TicketDetailsController());

  @override
  void initState() {
    super.initState();
    String? hour,min;
    String time = widget.data.duration!.trim();
    if(time.contains(".")){
      hour = time.split(".")[0];
      min = time.split(".")[1];
    }else if(time.contains(":")){
      hour = time.split(":")[0];
      min = time.split(":")[1];
    }
    ticketController.selectedTriage.value = widget.data.triage ?? "N/A";
    ticketController.selectedSubStatus.value = widget.data.subStatus ?? "N/A";
    ticketController.callId.value = widget.data.serviceCallNo ?? "N/A";
    ticketController.hours.text = hour ?? "00";
    ticketController.minutes.text = min ?? "00";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          title: const Text('Ticket Details'),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 0),
                color: AppColors.whiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${widget.data.serviceCallNo}",
                      style: AppTextStyle.grey646semi16,
                    ),
                    Text(
                      widget.data.subject?? "N/A",
                      style: AppTextStyle.black191medium16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonRow(
                            title: "Duration : ",
                            value: widget.data.duration?.trim() ?? "0.0",
                            style: AppTextStyle.black323semi16),
                        MaterialButton(
                          onPressed: ticketController.changeDuration,
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
                    commonRow(
                        title: "Status : ",
                        value: widget.data.callStatus ?? "N/A",
                        style: AppTextStyle.green47cSemi16),
                    10.sizedBoxHeight,
                    commonRow(
                        title: "Model : ",
                        value: widget.data.model ?? "N/A",
                        style: AppTextStyle.black323semi16),
                    10.sizedBoxHeight,
                    commonRow(
                        title: "ManuSN : ",
                        value: widget.data.manuSN ?? "N/A",
                        style: AppTextStyle.black323semi16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonRow(
                            title: "Triage : ",
                            value: widget.data.triage ?? "N/A",
                            style: AppTextStyle.black323semi16),
                        MaterialButton(
                          onPressed: ticketController.changeTriage,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonRow(
                          title: "subStatus : ",
                          value: widget.data.subStatus ?? "N/A",
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
                            value: "\n${widget.data.customerName}",
                            style: AppTextStyle.black323semi16),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse("tel:${widget.data.contactMobNo}"));
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
                        value: "\n${widget.data.contactMobNo}",
                        style: AppTextStyle.black323semi16),
                    10.sizedBoxHeight,
                    commonRow(
                        title: "Address",
                        value: "\n${widget.data.address}",
                        style: AppTextStyle.black323semi16),
                    10.sizedBoxHeight,
                    commonRow(
                        title: "Start Date",
                        value: "\n${widget.data.generateDate}",
                        style: AppTextStyle.black323semi16),
                    10.sizedBoxHeight,
                    commonRow(
                        title: "Remarks :",
                        value: "\n${widget.data.remarks}",
                        style: AppTextStyle.black323semi16),
                  ],
                ),
              ),
              // const Spacer(),
              CommonMaterialButton(
                  buttonText: "Stock Request",
                  onTap: () {
                    Get.to(() => StockRequest(
                          data: widget.data,
                        ));
                  }),
            ],
          ),
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
