import 'package:flutter/material.dart';
import 'package:service_call_management/utils/app_test_style.dart';

class CommonDropdownField extends StatelessWidget {
  CommonDropdownField(
      {required this.hintText, required this.dropdownList, super.key});

  List dropdownList;

  String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        padding: const EdgeInsets.symmetric(vertical: 12),
        items: dropdownList.map((category) {
          return DropdownMenuItem(
              value: category["id"], child: Text(category["name"]));
        }).toList(),
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle.grey84regular16,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ));
  }
}
