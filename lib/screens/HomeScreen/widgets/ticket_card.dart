import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/TicketsModel.dart';
import 'package:service_call_management/screens/ticket_details/ticket_details.dart';
import 'package:service_call_management/utils/app_assets.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_test_style.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.data,
  });
  final ServiceData data;

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
        color: data.callStatus?.toLowerCase() == "open"
            ? AppColors.green47CColor
            : data.callStatus?.toLowerCase() == "close"
                ? AppColors.redE25Color
                : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => TicketDetails(
                data: data,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("#${data.serviceCallNo}",
                            style: AppTextStyle.semiBoldTS.copyWith(
                                color: AppColors.grey646Color, fontSize: 16)),
                        Text(
                          data.subject ?? "",
                          style: AppTextStyle.semiBoldTS.copyWith(
                              color: AppColors.black191Color, fontSize: 16),
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse("tel:${data.contactMobNo}"));
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
                          value: data.duration ?? "0.0",
                          style: AppTextStyle.black323semi16),
                      4.sizedBoxHeight,
                      commonRow(
                          size: size,
                          title: "Model : ",
                          value: data.model ?? "N/A",
                          style: AppTextStyle.black323semi16),
                      4.sizedBoxHeight,
                      commonRow(
                          size: size,
                          title: "manuSN : ",
                          value: data.manuSN ?? "N/A",
                          style: AppTextStyle.black323semi16),
                      commonRow(
                          size: size,
                          title: "Triage : ",
                          value: data.triage?? "N/A",
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
                          value: data.callStatus ?? "N/A",
                          style: AppTextStyle.semiBoldTS.copyWith(
                            fontSize: 16,
                            color: data.callStatus?.toLowerCase() == "open"
                                ? AppColors.green47CColor
                                : data.callStatus?.toLowerCase() == "close"
                                    ? AppColors.redE25Color
                                    : Colors.grey,
                          )),
                      commonRow(
                          size: size,
                          title: "subStatus : ",
                          value: data.subStatus ?? "N/A",
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
                    data.address ?? "N/A",
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
      width: size.width * 0.4,
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
