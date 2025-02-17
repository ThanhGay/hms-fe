import 'dart:convert';

import 'package:android_hms/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiSignup {
  static Future<int> signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      String phoneNumber,
      String citizenIdentity,
      String dateOfBirth) async {
    final url = Uri.parse(
        "${APIConstants.api}add-customer"); // Thay bằng URL API thực tế
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "passWord": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "citizenIdentity": citizenIdentity,
        "dateOfBirth": dateOfBirth
      }),
    );
    return response.statusCode;
  }
}
