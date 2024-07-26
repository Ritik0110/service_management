import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:service_call_management/Models/sub_status_model.dart';
import 'package:service_call_management/common_widgets/common_button.dart';
import 'package:service_call_management/screens/HomeScreen/home_screen.dart';
import 'package:service_call_management/utils/app_test_style.dart';
import 'package:service_call_management/utils/extension/size_extension.dart';

import '../../services/network_api_services.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_url.dart';

class TicketDetailsController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getStatus();
  }

  StatusModel statusModel = StatusModel();
  List triageList = ["YES", "NO"];
  final _api = NetWorkApiService();
  var selectedSubStatus = "".obs;
  var selectedTriage = "".obs;
  var callId = "".obs;
  final hours = TextEditingController(text: "00");
  final minutes = TextEditingController(text: "00");

  void changeStatus() async {
    Get.dialog(Center(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.sizedBoxHeight,
              Text(
                'Change Sub Status',
                style: AppTextStyle.boldTS.copyWith(
                  fontSize: 20,
                  color: AppColors.black323Color,
                ),
              ),
              10.sizedBoxHeight,
              ListView.builder(
                itemBuilder: (context, index) {
                  return Obx(() => RadioListTile(
                      value: statusModel.subStatus?[index].subStatus,
                      groupValue: selectedSubStatus.value,
                      title: Text(
                        statusModel.subStatus![index].subStatus!,
                        style: AppTextStyle.black323semi14,
                      ),
                      onChanged: (value) {
                        selectedSubStatus.value = value!;
                        update();
                      }));
                },
                itemCount: statusModel.subStatus!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              CommonMaterialButton(
                buttonText: "Update Sub Status",
                onTap: () async {
                  var data = await _api.postApi(
                      AppUrl.updateStatus,
                      jsonEncode({
                        "SubStatus": selectedSubStatus.value,
                        "CallId": callId.value.toString()
                      }));
                  if (data["Result"] == 1) {
                    Fluttertoast.showToast(
                        msg: "SubStatus Updated successfully");
                    Get.deleteAll();
                    Get.to(() => const HomeScreen());
                  } else {
                    Fluttertoast.showToast(msg: "${data["Message"]} ");
                  }
                },
              ),
              10.sizedBoxHeight
            ],
          ),
        ),
      ),
    ));
  }

  void changeTriage() async {
    Get.dialog(Center(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.sizedBoxHeight,
              Text(
                'Change Triage',
                style: AppTextStyle.boldTS.copyWith(
                  fontSize: 20,
                  color: AppColors.black323Color,
                ),
              ),
              10.sizedBoxHeight,
              ListView.builder(
                itemBuilder: (context, index) {
                  return Obx(() => RadioListTile(
                      value: triageList[index],
                      groupValue: selectedTriage.value,
                      title: Text(
                        triageList[index],
                        style: AppTextStyle.black323semi14,
                      ),
                      onChanged: (value) {
                        selectedTriage.value = value;
                        update();
                      }));
                },
                itemCount: triageList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              CommonMaterialButton(
                buttonText: "Update Triage",
                onTap: () async {
                  var data = await _api.postApi(
                      AppUrl.updateTriage,
                      jsonEncode({
                        "Triaged": selectedTriage.value,
                        "CallId": callId.value.toString()
                      }));
                  print(data);
                  if (data["Result"] == 1) {
                    Fluttertoast.showToast(
                        msg: "Triage change successfully");
                    Get.deleteAll();
                    Get.to(() => const HomeScreen());
                  } else {
                    Fluttertoast.showToast(msg: "${data["Message"]} ");
                  }
                },
              ),
              10.sizedBoxHeight
            ],
          ),
        ),
      ),
    ));
  }

  void getStatus() async {
    var data = await _api.getApi(AppUrl.subStatus);
    statusModel = StatusModel.fromJson(data);
  }

  void changeDuration() async {
    Get.dialog(Center(
      child: SizedBox(
        child: Card(
          margin: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.sizedBoxHeight,
              Text(
                'Change Duration',
                style: AppTextStyle.boldTS.copyWith(
                  fontSize: 20,
                  color: AppColors.black323Color,
                ),
              ),
              10.sizedBoxHeight,
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonTextField(controller: hours, hint: "HH"),
                    const Text(" : ",style: TextStyle(fontSize: 30),),
                    commonTextField(controller: minutes, hint: "MM",isMin: true),
                  ],
                ),
              ),
              CommonMaterialButton(
                buttonText: "Update Duration",
                onTap: () async {
                  var data = await _api.postApi(
                      AppUrl.updateDuration,
                      jsonEncode({
                        "Duration": "${hours.text}:${minutes.text}",
                        "CallId": callId.value.toString()
                      }));
                  if (data["Result"] == 1) {
                    Fluttertoast.showToast(
                        msg: "Duration Updated successfully");
                    Get.deleteAll();
                    Get.to(() => const HomeScreen());

                  } else {
                    Fluttertoast.showToast(msg: "${data["Message"]} ");
                  }
                },
              ),
              10.sizedBoxHeight
            ],
          ),
        ),
      ),
    ));
  }
  commonTextField({required TextEditingController controller,required String hint,bool isMin = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,

        contentPadding: EdgeInsets.zero,
        constraints:
        const BoxConstraints(maxHeight: 40,maxWidth: 60),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey848Color),
        ),
      ),
      validator: (value) {
        print("value $value hello");
        if(value!.contains("."))
        {
          controller.text = value.replaceAll(".", "");
        }
        if(value.contains(",")){
          controller.text = value.replaceAll(",", "");
        }
        if(value.contains("-")){
          controller.text = value.replaceAll("-", "");
        }
        if(value.contains(" ")){
          controller.text = value.replaceAll(" ", "");
        }
        if(value != ""){
          if(int.parse(controller.text)>60 && isMin){
            controller.text = "59";
          }
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );
  }
}
