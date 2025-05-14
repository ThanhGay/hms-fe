import 'dart:convert';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class ApiLogin {
  static Future<String> loginUser(String email, String password) async {
    Response response;
    const String url = "${APIConstants.api}login";
    final prefs = await SharedPreferences.getInstance();
    print("toke longi ${prefs.getString("deviceToken")}");
    try {
      response = await dio.post(url, data: {
        "email": email,
        "password": password,
        "deviceToken": prefs.getString("deviceToken")
      });
      final data = response.data;

      final user = json.encode(data['user']);

      prefs.setString(
          "conversationId", "receptionist-${data['user']['userId']}");
      prefs.setString('user', user);
      prefs.setString('token', data['token']);
      prefs.setString('role', data['role']);

      return "Success";
    } on DioException catch (e) {
      print("ERROR: ${e}");
      return "${e.response} ";
    }
  }
}
