import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/ticket_details/ticket_details.dart';
import 'package:service_call_management/utils/app_assets.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_test_style.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.ticketId,
    required this.ticketTitle,
    required this.ticketTime,
    required this.ticketLocation,
    required this.ticketStatus,
    required this.model,
    required this.manuSN,
    required this.ticketSubStatus,
    required this.ticketPriority,
    required this.customerName,
    required this.contactPerson,
    required this.contactNumber,
    required this.startDate,
    required this.endDate,
  });
  final String ticketId;
  final String ticketTitle;
  final String ticketTime;
  final String model;
  final String manuSN;
  final String ticketLocation;
  final String ticketStatus;
  final String ticketSubStatus;
  final String ticketPriority;
  final String customerName;
  final String contactPerson;
  final String contactNumber;
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          )
        ],
        color: ticketStatus.toLowerCase() == "open"
            ? AppColors.green47CColor
            : ticketStatus.toLowerCase() == "close"
                ? AppColors.redE25Color
                : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => TicketDetails(
                subStatus: ticketSubStatus,
                ticketId: ticketId,
                ticketTitle: ticketTitle,
                ticketStatus: ticketStatus,
                ticketLocation: ticketLocation,
                ticketTime: ticketTime,
                ticketPriority: ticketPriority,
                contactNumber: contactNumber,
                contactPerson: contactPerson,
                customerName: customerName,
                startDate: startDate,
                endDate: endDate,
                model: model,
                manuSN: manuSN,
              ));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 6),
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("#$ticketId",
                          style: AppTextStyle.semiBoldTS.copyWith(
                              color: AppColors.grey646Color, fontSize: 16)),
                      Text(
                        ticketTitle,
                        style: AppTextStyle.semiBoldTS.copyWith(
                            color: AppColors.black191Color, fontSize: 16),
                      )
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse("tel:$contactNumber"));
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        child: const Icon(
                          Icons.call,
                          color: AppColors.green34CColor,
                        )),
                  )
                ],
              ),
              Divider(
                color: Colors.grey.shade200,
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonRow(
                        size: size,
                          title: "Duration : ",
                          value: ticketTime,
                          style: AppTextStyle.black323semi16),
                      4.sizedBoxHeight,
                      commonRow(
                        size: size,
                          title: "Model : ",
                          value: model,
                          style: AppTextStyle.black323semi16),
                      4.sizedBoxHeight,
                      commonRow(
                        size: size,
                          title: "manuSN : ",
                          value: manuSN,
                          style: AppTextStyle.black323semi16),
                      commonRow(
                          size: size,
                          title: "Triage : ",
                          value: ticketSubStatus,
                          style: AppTextStyle.black323semi16),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonRow(
                        size: size,
                          title: "Status : ",
                          value: ticketStatus,
                          style: AppTextStyle.semiBoldTS.copyWith(
                            fontSize: 16,
                            color: ticketStatus.toLowerCase() == "open"
                                ? AppColors.green47CColor
                                : ticketStatus.toLowerCase() == "close"
                                ? AppColors.redE25Color
                                : Colors.grey,
                          )),
                      commonRow(
                        size: size,
                          title: "subStatus : ",
                          value: ticketSubStatus,
                          style: AppTextStyle.black323semi16),

                    ],
                  )
                ],
              ),
              4.sizedBoxHeight,
              Row(
                children: [
                  Image.asset(
                    AppAssets.locationIcon,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: Text(
                    ticketLocation,
                    style: AppTextStyle.mediumTS
                        .copyWith(fontSize: 14, color: AppColors.black191Color),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget commonRow(
      {required String title,
      required String value,
        required Size size,
      required TextStyle style,
      bool reversed = false}) {
    return SizedBox(
      width: size.width*0.4,
      child: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text: TextSpan(
            text: title,
            style: reversed ? style : AppTextStyle.grey84regular16,
             spellOut: true,
            children: [
              TextSpan(
                  text: value,
                  style: reversed ? AppTextStyle.grey84regular16 : style)
            ]),
      ),
    );
  }
}
