import 'package:flutter/material.dart';
import 'package:service_call_management/utils/app_test_style.dart';

class CommonDropdownField extends StatefulWidget {
  CommonDropdownField(
      {required this.hintText, required this.dropdownList,required this.onChange, super.key});

  List<DropdownMenuItem<String>>? dropdownList;
  Function(String?)? onChange;
  final String hintText;

  @override
  State<CommonDropdownField> createState() => _CommonDropdownFieldState();
}

class _CommonDropdownFieldState extends State<CommonDropdownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Please select a value';
          }
          return null;
        },
        padding: const EdgeInsets.symmetric(vertical: 12),
        items: widget.dropdownList,
        onChanged: widget.onChange,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyle.grey84regular16,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ));
  }
}
