import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
      final response = await dio.get(url, queryParameters: queryParameters);
      data = responseData(response);
      return data;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }on DioException catch (e) {
      return e.toString();
    }
  }

  @override
  Future postApi(String url, body) async {

    dynamic data;
    try {
      final response = await dio
          .post(url,
          data: body) // if body of api is written in raw form then encoded it otherwise send only body to the api
          .timeout(const Duration(seconds: 15));
      data = responseData(response);
      return data;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } catch (e) {
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
