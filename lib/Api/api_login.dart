import 'dart:convert';
import 'package:android_hms/GlobalData.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class ApiLogin {
  static Future<int> loginUser(String email, String password) async {
    const String url = "${GlobalData.api}Login";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json', // Xác định kiểu dữ liệu gửi đi
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('user', data['user']);
      // await prefs.setString('token', data['token']);
      // await prefs.setString('role', data['role']);
    }
    return response.statusCode;
  }
}
