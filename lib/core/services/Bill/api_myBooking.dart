
import 'package:dio/dio.dart';

import 'package:android_hms/core/services/dioClient.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:flutter/widgets.dart';

class ApiBill {
  static Future<String> myBooking(BuildContext content) async {
    Response response;

    const String url = "${APIConstants.apiBill}/get-my-booking";
    final uri = Uri.parse(url);

    try {
      response = await DioClient().dio.getUri(uri);
      print("data return ${response}");
      return response.data['message'];
    } on DioException catch (e) {
      return ("${e.response}");
    }
  }
}
