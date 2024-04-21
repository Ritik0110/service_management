import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/common_widgets/common_dropdown.dart';
import 'package:service_call_management/screens/purchase_request_form/purchase_request_form_controller.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

import '../../common_widgets/common_button.dart';
import '../../utils/app_colors.dart';

class PurchaseRequestForm extends StatelessWidget {
  PurchaseRequestForm({super.key, required this.isPurchase});

  final bool isPurchase;
  final formController = Get.put(PurchaseFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isPurchase?'Purchase Request Form':"Inventory Transfer Form"),
      ),
      body: Form(
        key: formController.formKey,
        child: Column(
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
                  Text(
                    'Requirement Date',
                    style: AppTextStyle.black323regular14,
                  ),
                  10.sizedBoxHeight,
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: formController.dateController,
                    decoration: InputDecoration(
                      hintText: "DD/MM/YYYY",
                      hintStyle: AppTextStyle.grey84regular16,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      suffixIcon: const Icon(
                        Icons.date_range_rounded,
                        color: AppColors.grey848Color,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select date';
                      }
                      return null;
                    },
                    readOnly: true,
                    onTap: () => formController.selectDate(context),
                  ),
                  10.sizedBoxHeight,
                  Text(
                    'from Warehouse',
                    style: AppTextStyle.black323regular14,
                  ),
                  Obx(() => CommonDropdownField(
                    onChange:formController.onFromWarehouseChange,
                    hintText: 'Select Warehouse',
                    dropdownList: !formController.isLoading.value
                        ? formController.warehouseList
                        : null,
                  )),
                  !isPurchase
                      ? Text(
                          'to Warehouse',
                          style: AppTextStyle.black323regular14,
                        )
                      : const SizedBox(),
                  !isPurchase
                      ? Obx(() => CommonDropdownField(
                          onChange: formController.onToWarehouseChange,
                            hintText: 'Select Warehouse',
                            dropdownList: !formController.isLoading.value
                                ? formController.warehouseList
                                : null,
                          ))
                      : const SizedBox(),

                ],
              ),
            ),
            const Spacer(),
            CommonMaterialButton(
                buttonText: "Choose Item",
                onTap:formController.submitForm
            )
          ],
        ),
      ),
    );
  }
}
