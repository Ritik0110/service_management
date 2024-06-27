import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:service_call_management/Models/employee_model.dart';
import 'package:service_call_management/Models/TicketsModel.dart';

import 'package:service_call_management/utils/app_variables.dart';

import 'app_url.dart';

class ApiHelper {
  static Dio dio = Dio(BaseOptions(
    baseUrl: AppUrl.mainBaseUrl,
  ));
  static Future<String?> getTickets() async {
    try {
      final response = await dio.post(AppUrl.getTickets, data: {
        "EmpCode": AppVariables.employeeModel.employeeData?[0].employeeCode,
        "Page": 0
      });
      print("Response: $response");
      AppVariables.ticketsModel =
          TicketsModel.fromJson(json.decode(response.toString()));
      return "1";
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      return "Failed to load data";
    }
  }

  static Future<String> SignIn(
    String userId,
    String password,
  ) async {
    try {
      final response = await dio
          .post(AppUrl.login, data: {"UserId": userId, "Password": password});
      EmployeeModel employeeModel =
          EmployeeModel.fromJson(json.decode(response.toString()));
      AppVariables.employeeModel = employeeModel;
      if (employeeModel.result == 1) {
        return "1";
      } else {
        return employeeModel.message ?? "";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
      return "Something went wrong";
    }
  }
}
