import 'dart:convert';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogin {
  static Future<int> loginUser(String email, String password) async {
    const String url = "${APIConstants.api}Login";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json', // Xác định kiểu dữ liệu gửi đi
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      final user = json.encode(data['user']);
      prefs.setString('user', user);
      prefs.setString('token', data['token']);
      prefs.setString('role', data['role']);
    }
    return response.statusCode;
  }
}
