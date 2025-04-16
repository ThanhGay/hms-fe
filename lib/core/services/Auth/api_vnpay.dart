import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class ApiVnpay {
  static Future<String> Vnpay(
      int orderId, double amount, String orderDesc, String orderType) async {
    // final prefs = await SharedPreferences.getInstance();
    //   await prefs.remove('token');
    //   print('🧹 Token đã được xóa');

    const String url = "${APIConstants.api}api/payment/create-payment-url";

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token =
          prefs.getString('token'); // Token đã lưu sau khi đăng nhập

      if (token == null) {
        print(" Không tìm thấy token");
        return "No token";
      }

      final response = await dio.post(
        url,
        data: {
          "orderId": orderId,
          "amount": amount,
          "orderDesc": orderDesc,
          "orderType": orderType,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      final data = response.data;
      prefs.setString('paymentUrl', data['paymentUrl']);
      print("Giá trị response: $data");

      return data['paymentUrl'];
    } on DioException catch (e) {
      print("Lỗi gọi API: ${e.message}");
      if (e.response != null) {
        print("Response status: ${e.response?.statusCode}");
        print("Response data: ${e.response?.data}");
      }
      return "Error: ${e.message}";
    }
  }
}
