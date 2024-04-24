import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_call_management/screens/SignInScreen/sign_in_controller.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';
import 'package:service_call_management/utils/form_validators.dart';

import '../../utils/app_colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController controller = Get.put(SignInController(),);
    final formKey = GlobalKey<FormState>();
    controller.loadStoredData();
    return Scaffold(
      backgroundColor: AppColors.blue2F6Color,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Welcome To",style:  AppTextStyle.regularTS.copyWith(
                     color: AppColors.whiteColor,
                      fontSize: 25),),
                  Text("SAP Business One\nService Call Parts\nRequests",style: AppTextStyle.boldTS.copyWith(
                      fontSize: 25, color: AppColors.whiteColor),),
                  12.sizedBoxHeight,
                 const Image(image: AssetImage("assets/images/app_logo.png"),height: 50,),
                  36.sizedBoxHeight,
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'SIGN IN',
                            style: AppTextStyle.semiBoldTS.copyWith(
                              color: AppColors.black323Color,
                              fontSize: 24,

                            )
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                           CustomTextFormField(
                            validator: FormValidators.requiredFieldValidator,
                            controller: controller.emailController,
                            title: "SAP User ID ",
                            isRequired: false,
                            hint: "Enter SAP User ID",
                          ),
                           Obx(
                             () =>  CustomTextFormField(
                               validator: FormValidators.requiredFieldValidator,
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              title: "Password",
                              isRequired: false,
                              hint: "Enter password",
                              suffix_icon: InkWell(onTap: () {
                                controller.togglePasswordVisibility();
                              },child: Icon(controller.isPasswordVisible.value==false?Icons.visibility_off_outlined:Icons.visibility_outlined,opticalSize: 1, )),
                          ),
                           ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Obx(
                                () =>  Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  side: const BorderSide(
                                      strokeAlign: 5,
                                      color: Colors.grey,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  value: controller.isRememberMe.value,
                                  onChanged: (value) {
                                    controller.toggleRememberMe();
                                  },
                                ),
                              ),
                               Text(
                                'Remember Password',
                                style: AppTextStyle.regularTS.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green33AColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if(formKey.currentState?.validate() == true){

                            controller.signIn();
                              }
                            },
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child:Text('Sign In',style:  AppTextStyle.mediumTS.copyWith(fontSize: 16,color: AppColors.whiteColor,)),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Obx(
                                  () =>  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(controller.errorMessage.value,style: AppTextStyle.boldTS.copyWith(
                                fontSize: 12,
                                color: AppColors.redE25Color,
                              ),),
                                  ),
                            ),
                          ),
                        ],
                      ),
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
    this.fontWeightForTitle, this.obscureText,
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
  final bool? obscureText;
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
            obscureText: obscureText ?? false,
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
            style: AppTextStyle.regularTS.copyWith(
              fontWeight: FontWeight.normal,
              color: AppColors.black323Color,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixText: prefixText,
              prefixStyle: prefixTextStyle,
              hintText: hint,
              hintStyle: AppTextStyle.regularTS
                  .copyWith(color: AppColors.grey848Color, fontSize: 16),
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
              style: AppTextStyle.regularTS.copyWith(
                fontSize: 14,
                // fontWeight: fontWeight ?? FontWeight.normal,
                color: AppColors.black323Color,
              ),
            ),
            isRequired
                ? const TextSpan(
                    text: "*",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFFF0000),
                        fontFamily: "Roboto"),
                  )
                : const TextSpan(),
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
