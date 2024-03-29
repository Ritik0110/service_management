import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:service_call_management/screens/HomeScreen/home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color backGroundColor = const Color(0xFF2f67de);
    Color greenButtonBackgroundColor = const Color(0xFF33af59);

    return Scaffold(
      backgroundColor: backGroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          letterSpacing: 1.5,
                          height: 1.5,
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Welcome To\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'SAP Business One\nService Call Management',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const CustomTextFormField(title: "Email / Phone Number ", isRequired: false,hint: "Enter Email/ Phone Number",),
                        const CustomTextFormField(title: "Password", isRequired: false,hint: "Enter password",suffix_icon: Icon(Icons.visibility_off_outlined),),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Checkbox(

                              side: const BorderSide(strokeAlign: 5,color: Colors.grey,width: 1,style: BorderStyle.solid),
                              value: false, onChanged: (value) {

                            },),

                               const Text(
                                'Remember Password',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),


                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenButtonBackgroundColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text('Sign In'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.isRequired,
    this.hint,
    this.prefix_icon,
    this.suffix_icon,
    this.max_line,
    this.controller,
    this.validator,
    this.maxLength,
    this.inputType,
    this.isReadOnly,
    this.autofillHints,
    this.onTapOutside,
    this.onChanged,
    this.prefixText,
    this.prefixTextStyle,
    this.fontWeightForTitle,
  }) : super(key: key);
  final String title;
  final bool isRequired;
  final String? hint;
  final Iterable<String>? autofillHints;
  final Widget? prefix_icon;
  final Widget? suffix_icon;
  final int? max_line;
  final int? maxLength;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? isReadOnly;
  final TapRegionCallback? onTapOutside;
  final ValueChanged<String>? onChanged;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final FontWeight? fontWeightForTitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextFormFieldLabel(
            title: title,
            isRequired: isRequired,
            fontWeight: fontWeightForTitle,
          ),
          TextFormField(
            onTapOutside: onTapOutside,
            onChanged: onChanged,
            autofocus: false,
            enableSuggestions: true,
            autofillHints: autofillHints,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: isReadOnly ?? false,
            keyboardType: inputType,
            maxLength: maxLength,
            validator: validator,
            controller: controller,
            style: const TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.normal,
              color: Color(0xFF323232),
              fontSize: 14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixText: prefixText,
              prefixStyle: prefixTextStyle,
              hintText: hint,
              hintStyle: const TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFC1C1C1),
                  fontSize: 14),
              suffixIcon: suffix_icon,
              counterText: "",
              prefixIcon: prefix_icon,
            ),
            maxLines: max_line ?? 1,
          ),
        ],
      ),
    );
  }
}

class CustomTextFormFieldLabel extends StatelessWidget {
  const CustomTextFormFieldLabel(
      {Key? key,
      required this.title,
      required this.isRequired,
      this.fontWeight})
      : super(key: key);
  final String title;
  final bool isRequired;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 26,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: Color(0xFF323232),
                  fontFamily: "Roboto"),
            ),
            isRequired
                ? const TextSpan(
                    text: "*",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFFF0000),
                        fontFamily: "Roboto"),
                  )
                : const TextSpan(),
          ]),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
