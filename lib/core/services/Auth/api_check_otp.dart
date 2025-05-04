import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class ApiCheckOTP {
  static Future<int> checkOtp(String email, String otp) async {
    Response response;
    final String url = "${APIConstants.api}check-otp";
    
    final body = {
      "email": email,
      "otp": otp,
    };

    try {
      response = await dio.post(
        url,
        data: body,
      );

      return response.statusCode!;
    } on DioException catch (e) {
      print("Error: ${e.response?.data}");
      return -1;
    }
  }
}
