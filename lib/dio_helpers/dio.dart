import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class dio_helpers {
  static Dio mydio = Dio(BaseOptions(
    baseUrl: "https://student.valuxapps.com/api/",
    receiveDataWhenStatusError: true,
  ));

  static Future<Response> getData(
      {@required String url,
      Map<String, dynamic> query,
      String token,
      String lan = "ar"}) async {
    mydio.options.headers = {
      "lang": lan,
      "Authorization": token ?? "",
      "Content-Type": "application/json",
    };

    return await mydio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {@required String url,
      Map<String, dynamic> data,
      Map<String, dynamic> query,
      String token,
      String lan = "en"}) async {
    mydio.options.headers = {
      "lang": lan,
      "Authorization": token ?? "",
      "Content-Type": "application/json",
    };
    return mydio.post(url, queryParameters: query, data: data);
  }
}
