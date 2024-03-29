import 'package:flutter/material.dart';
import 'package:service_call_management/utils/app_test_style.dart';

class CommonDropdownField extends StatelessWidget {
  CommonDropdownField({required this.hintText ,super.key});

  final List<String> dropdownList = ['One', 'Two', 'Three'];

  String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
        items: dropdownList.map((String category) {
          return DropdownMenuItem(value: category, child: Text(category));
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
