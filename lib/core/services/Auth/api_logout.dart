import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogout {
  static Future<int> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? tokenData = prefs.getString('token');

    if (tokenData == null || tokenData.isEmpty) {
      print("Không tìm thấy token");
      return 401; // Unauthorized
    }

    print("Token: $tokenData");

    const String url = "${APIConstants.api}logout";
    final uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $tokenData",
      },
    );

    if (response.statusCode == 200) {
      await prefs.clear(); // Xóa toàn bộ dữ liệu
    } else {
      print("Lỗi khi logout: ${response.statusCode}");
    }

    return response.statusCode;
  }
}
