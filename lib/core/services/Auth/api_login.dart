import 'dart:convert';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class ApiLogin {
  static Future<String> loginUser(String email, String password,String deviceToken ) async {
    Response response;
    const String url = "${APIConstants.api}login";

    try {
      response =
          await dio.post(url, data: {"email": email, "password": password,"deviceToken": deviceToken});

      final data = response.data;

      final prefs = await SharedPreferences.getInstance();
      final user = json.encode(data['user']);

      prefs.setString('user', user);
      prefs.setString('token', data['token']);
      prefs.setString('role', data['role']);

      return "Success";
    } on DioException catch (e) {
      return "${e.response} ";
    }
  }
}
