import 'package:flutter/material.dart';
import 'package:service_call_management/screens/ticket_details/ticket_details.dart';
import 'package:service_call_management/utils/app_assets.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_test_style.dart';
class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key, required this.ticketId, required this.ticketTitle, required this.ticketTime, required this.ticketPriority, required this.ticketLocation, required this.ticketStatus,
  });
  final String ticketId;
  final String ticketTitle;
  final String ticketTime;
  final String ticketPriority;
  final String ticketLocation;
  final String ticketStatus;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TicketDetails()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: ticketStatus.toLowerCase() == "open"? AppColors.green47CColor:AppColors.redE25Color,
          borderRadius: BorderRadius.circular(10),
        ),
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
                      Text(
                          "#${ticketId}",
                          style: AppTextStyle.semiBoldTS.copyWith(
                              color: AppColors.grey646Color,
                              fontSize: 16
                          )
                      ),
                      Text(
                        ticketTitle,
                        style: AppTextStyle.semiBoldTS.copyWith(
                            color: AppColors.black191Color,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      child: const Icon(
                        Icons.call,
                        color:AppColors.green34CColor,
                      ))
                ],
              ),
              Divider(
                color: Colors.grey.shade200,
                thickness: 2,
              ),
              Row(
                children: [
                  Text(
                    "Time : ",
                    style: AppTextStyle.regularTS.copyWith(
                      fontSize: 16,
                      color: AppColors.grey848Color,
                    ),
                  ),
                  Text(
                    ticketTime,
                    style: AppTextStyle.semiBoldTS.copyWith(
                        color: AppColors.black323Color,
                        fontSize: 16
                    ),),
                  const Spacer(),
                  Text(
                    "Priority : ",
                    style: AppTextStyle.regularTS.copyWith(
                      fontSize: 16,
                      color: AppColors.grey848Color,
                    ),
                  ),
                  Text(
                    ticketPriority,
                    style: AppTextStyle.semiBoldTS.copyWith(
                        fontSize: 16,
                        color: ticketPriority.toLowerCase() == "high"? AppColors.purple9C5Color:ticketPriority.toLowerCase() == "low"? AppColors.blue3BCColor:AppColors.yellowFF9Color,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                   Image.asset(
                   AppAssets.locationIcon,
                    height: 15,),
                  const SizedBox(width: 4,),
                  Expanded(
                      child: Text(
                        "Gitschiner Str., Berlin Germany",
                        style: AppTextStyle.mediumTS.copyWith(
                            fontSize: 14,
                            color: AppColors.black191Color
                        ),
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
}


