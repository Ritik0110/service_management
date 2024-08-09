// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_test_style.dart';

class CommonItemView extends StatefulWidget {
  CommonItemView({
    super.key,
    required this.title,
    required this.subTitle,
     this.increment,
     this.decrement,
    required this.groupName,
    this.remove,
    required this.warehouse,
    required this.subQty,
    required this.quantity,
  });
  String title;
  String subTitle;
  String groupName;
  int quantity;
  int subQty;
  String warehouse;
  Function()? remove;
  Function()? increment;
  Function()? decrement;

  @override
  State<CommonItemView> createState() => _CommonItemViewState();
}

class _CommonItemViewState extends State<CommonItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      color: AppColors.scaffoldColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.sizedBoxWidth,
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      softWrap: true,
                      style: AppTextStyle.grey84regular14,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.subTitle,
                      style: AppTextStyle.black191medium16,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    5.sizedBoxHeight,
                    Text(
                      widget.groupName,style: AppTextStyle.grey84regular14,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 28,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.grey848Color, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: widget.decrement,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(5)),
                            ),
                            width: 25,
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                size: 20,
                                color: AppColors.grey848Color,
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: AppColors.grey848Color,
                          thickness: 1,
                          width: 0,
                        ),
                        SizedBox(
                          width: 30,
                          child: Center(
                            child: Text("${widget.subQty}",
                                overflow: TextOverflow.visible,
                                style: AppTextStyle.black323medium14),
                          ),
                        ),
                        const VerticalDivider(
                          color: AppColors.grey848Color,
                          thickness: 1,
                          width: 2,
                        ),
                        InkWell(
                          onTap: widget.increment,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(5)),
                            ),
                            width: 25,
                            child: Center(
                              child: InkWell(
                                onTap: widget.increment,
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: AppColors.grey848Color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.sizedBoxHeight,
                  commonRow(
                      title: "Warehouse : ",
                      value: "${widget.warehouse}",
                      style: AppTextStyle.black323semi14),
                  commonRow(
                      title: "In Stock Qty : ",
                      value: "${widget.quantity}",
                      style: AppTextStyle.black323semi14)
                ],
              ),
              10.sizedBoxWidth,
            ],
          ),
          widget.remove != null
              ? Row(
                  children: [
                    MaterialButton(
                      onPressed: widget.remove,
                      child: Row(
                        children: [
                          Text(
                            "Remove",
                            style: AppTextStyle.grey84regular14,
                          ),
                          const Icon(
                            Icons.delete,
                            color: AppColors.grey848Color,
                          )
                        ],
                      ),
                    )
                  ],
                )
              : const SizedBox(),
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
      maxLines: 3,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      text: TextSpan(
          text: title,
          style: reversed ? style : AppTextStyle.grey84regular14,
          children: [
            TextSpan(
                text: value,
                style: reversed ? AppTextStyle.grey84regular16 : style)
          ]),
    );
  }
}
