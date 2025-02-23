import 'dart:convert';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiSendOTP {
  static Future<int> sendOtp(String email) async {
    const String url = "${APIConstants.api}forgot-password";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    return response.statusCode;
  }
}
