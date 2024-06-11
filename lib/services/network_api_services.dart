import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:service_call_management/services/base_api_services.dart';
import '../utils/app_url.dart';
import 'app_exceptions.dart';

class NetWorkApiService extends BaseApiServices {
  static Dio dio = Dio(BaseOptions(
    baseUrl: AppUrl.baseUrl,
  ));
  @override
  Future getApi(String url, {Map<String, dynamic>? queryParameters}) async {
    dynamic data;
    try {
      Get.dialog(
          const PopScope(
            canPop: false,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          barrierDismissible: false);
      final response = await dio.get(url, queryParameters: queryParameters);
      data = responseData(response);
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      return data;
    } on SocketException {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      throw InternetException();
    } on RequestTimeOut {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      throw RequestTimeOut();
    }on DioException catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      return e.toString();
    }
  }

  @override
  Future postApi(String url, body) async {
    dynamic data;
    try {
      Get.dialog(
          const PopScope(
            canPop: false,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          barrierDismissible: false);
      final response = await dio
          .post(url,
          data: body) // if body of api is written in raw form then encoded it otherwise send only body to the api
          .timeout(const Duration(seconds: 15));
      data = responseData(response);
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      return data;
    } on SocketException {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      throw InternetException();
    } on RequestTimeOut {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      throw RequestTimeOut();
    }on DioException catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      return e.toString();
    }
  }
}

dynamic responseData(Response response) {
  switch (response.statusCode) {
    case 200:
      var data = jsonDecode(response.toString());
      return data;
    case 400:
      throw InvalidUrlException();
    default:
      throw FetchDataException(response.statusCode.toString());
  }
}
