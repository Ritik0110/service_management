import 'package:flutter/material.dart';
import 'package:service_call_management/utils/app_test_style.dart';

class CommonDropdownField extends StatefulWidget {
  CommonDropdownField(
      {required this.hintText, required this.dropdownList, super.key});

  List<DropdownMenuItem<String>>? dropdownList;

  final String hintText;

  @override
  State<CommonDropdownField> createState() => _CommonDropdownFieldState();
}

class _CommonDropdownFieldState extends State<CommonDropdownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        padding: const EdgeInsets.symmetric(vertical: 12),
        items: widget.dropdownList,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyle.grey84regular16,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ));
  }
}
