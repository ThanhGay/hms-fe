import 'package:dio/dio.dart';

import 'package:android_hms/core/services/dioClient.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogout {
  static Future<String> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();

    Response response;

    const String url = "${APIConstants.api}logout";
    final uri = Uri.parse(url);

    try {
      response = await DioClient().dio.postUri(uri);
      await prefs.clear();

      if (response.statusCode == 200) {
        return "Success";
      } else {
        print("Lỗi khi logout: ${response.statusCode}");
        return "Failed";
      }
    } on DioException catch (e) {
      return ("${e.response}");
    }
  }
}
