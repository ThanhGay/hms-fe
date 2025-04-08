import 'dart:convert';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class ApiVnpay {
  static Future<String> Vnpay(
      int orderId, double amount, String orderDesc, String orderType) async {
    Response response;
    const String url = "${APIConstants.api}api/payment/create-payment-url";

    try {
      response = await dio.post(url, data: {
        "orderId": orderId,
        "amount": amount,
        "orderDesc": orderDesc,
        "orderType": orderType
      });

      final data = response.data;

      final prefs = await SharedPreferences.getInstance();

      prefs.setString('paymentUrl', data['paymentUrl']);

      return "Success";
    } on DioException catch (e) {
      return "${e.response} ";
    }
  }
}
