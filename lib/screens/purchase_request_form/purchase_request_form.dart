import 'package:flutter/material.dart';
import 'package:service_call_management/common_widgets/common_dropdown.dart';
import 'package:service_call_management/utils/app_test_style.dart';

class PurchaseRequestForm extends StatelessWidget {
  const PurchaseRequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Request Form'),
      ),
      body:Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text('Product Serial Number',style: AppTextStyle.black323regular16,),
            CommonDropdownField(hintText: 'Select Product Serial Number'),
            Text('To Warehouse',style: AppTextStyle.black323regular16,),
            CommonDropdownField(hintText: 'Select Warehouse'),
          ],
        ),
      ),
    );
  }
}
