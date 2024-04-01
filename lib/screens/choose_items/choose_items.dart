import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:service_call_management/common_widgets/common_button.dart';
import 'package:service_call_management/screens/purchase_order_review/purhcase_order_review.dart';
import 'package:service_call_management/utils/app_colors.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

class ChooseItems extends StatelessWidget {
  const ChooseItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Items'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sync_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                        title: Text(
                          "Printers",
                          style: AppTextStyle.black323semi14,
                        ),
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: AppColors.scaffoldColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(value: false, onChanged: (value) {}),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "HP LaserJet Pro M15w",
                                        softWrap: true,
                                        style: AppTextStyle.black323medium14,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "\$400",
                                        style: AppTextStyle.black323semi16,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "A0001",
                                        style: AppTextStyle.grey84regular14,
                                      ),
                                      Text(
                                        "-7186",
                                        style: AppTextStyle.grey84regular14,
                                      ),
                                    ],
                                  ),
                                ),
                                10.sizedBoxWidth
                              ],
                            ),
                          ),
                        ]),
                    ExpansionTile(
                        title: Text(
                      "Monitors",
                      style: AppTextStyle.black323semi14,
                    )),
                    ExpansionTile(
                        title: Text(
                      "USB Cables",
                      style: AppTextStyle.black323semi14,
                    )),
                    ExpansionTile(
                        title: Text(
                      "Computer mouse",
                      style: AppTextStyle.black323semi14,
                    )),
                    ExpansionTile(
                        title: Text(
                      "Mother board",
                      style: AppTextStyle.black323semi14,
                    )),
                    ExpansionTile(
                        title: Text(
                      "Hard Disks",
                      style: AppTextStyle.black323semi14,
                    )),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.whiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "(5) ",
                            style: AppTextStyle.black323semi16,
                            children: [
                          TextSpan(
                            text: "Items Selected",
                            style: AppTextStyle.grey7A7medium16,
                          )
                        ])),
                    CommonMaterialButton(
                      buttonText: "Review Order",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PurchaseOrderReviewPage()));
                      },
                      width: 200,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
