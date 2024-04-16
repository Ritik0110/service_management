// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_test_style.dart';

class CommonItemView extends StatefulWidget {
  CommonItemView(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.increment,
      required this.decrement,
      required this.quantity,
      required this.imageUrl});
  String imageUrl;
  String title;
  String subTitle;
  int quantity;
  Function() increment;
  Function() decrement;

  @override
  State<CommonItemView> createState() => _CommonItemViewState();
}

class _CommonItemViewState extends State<CommonItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      color: AppColors.scaffoldColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://4.imimg.com/data4/GL/UP/MY-5812789/3-printer.jpg",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          10.sizedBoxWidth,
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  softWrap: true,
                  style: AppTextStyle.black323semi14,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.subTitle,
                  style: AppTextStyle.grey7A7medium14,
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey848Color, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: widget.decrement,
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                    color: AppColors.grey848Color,
                  ),
                ),
                const VerticalDivider(
                  color: AppColors.grey848Color,
                  thickness: 1,
                ),
                Text("${widget.quantity}",
                    overflow: TextOverflow.visible,
                    style: AppTextStyle.black323medium14),
                const VerticalDivider(
                  color: AppColors.grey848Color,
                  thickness: 1,
                ),
                InkWell(
                  onTap: widget.increment,
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: AppColors.grey848Color,
                  ),
                ),
              ],
            ),
          ),
          10.sizedBoxWidth
        ],
      ),
    );
  }
}
