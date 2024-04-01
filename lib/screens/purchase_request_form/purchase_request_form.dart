import 'package:flutter/material.dart';
import 'package:service_call_management/common_widgets/common_dropdown.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

import '../../common_widgets/common_button.dart';

class PurchaseRequestForm extends StatefulWidget {
   const PurchaseRequestForm({super.key});

  @override
  State<PurchaseRequestForm> createState() => _PurchaseRequestFormState();
}

class _PurchaseRequestFormState extends State<PurchaseRequestForm> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Request Form'),
      ),
      body: Column(
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
                  'Product Serial Number',
                  style: AppTextStyle.black323regular14,
                ),
                CommonDropdownField(hintText: 'Select Product Serial Number'),
                Text(
                  'Requirement Date',
                  style: AppTextStyle.black323regular14,
                ),
                10.sizedBoxHeight,
                TextFormField(
                    decoration: const InputDecoration(
                      hintText: "DD/MM/YYYY",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      suffixIcon: Icon(Icons.date_range_rounded),
                    ),
                    readOnly: true,
                    onTap: ()=> _selectDate(context),
                ),
                10.sizedBoxHeight,
                Text(
                  'To Warehouse',
                  style: AppTextStyle.black323regular14,
                ),
                CommonDropdownField(hintText: 'Select Warehouse'),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("If Inventory Transfer has Based",
                      style: AppTextStyle.grey7A7medium14),
                ),
                20.sizedBoxHeight,
                Text(
                  'From Warehouse',
                  style: AppTextStyle.black323regular14,
                ),
                CommonDropdownField(hintText: 'Select Warehouse'),
                CommonMaterialButton(buttonText: "Choose Item", onTap: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
