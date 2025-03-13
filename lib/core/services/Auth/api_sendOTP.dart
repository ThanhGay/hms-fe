import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class ApiSendOTP {
  static Future<int> sendOtp(String email) async {
    Response response;
    const String url = "${APIConstants.api}forgot-password";
    final formData = FormData.fromMap({
      'email': email,
    });
    try {
      print("send otp");
      response = await dio.post(url, data: formData);

      print("send otp: ${response.data}");

      return response.statusCode!;
    } on DioException catch (e) {
      print("error: ${e}");
      return -1;
    }
  }
}
