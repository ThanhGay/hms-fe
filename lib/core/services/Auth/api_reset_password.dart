import 'dart:convert';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiResetPassword {
  static Future<int> resetPassword(String email, String otp, String password) async {
    const String url = "${APIConstants.api}update-password"; 
    final uri = Uri.parse(url);

    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "otp": otp, "password":password }),
    );
  


    return response.statusCode;
  }
}
