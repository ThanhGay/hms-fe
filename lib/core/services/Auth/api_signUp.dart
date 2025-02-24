import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class ApiSignup {
  static Future<String> signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      String phoneNumber,
      String citizenIdentity,
      String dateOfBirth) async {
    Response response;
    final url = "${APIConstants.api}add-customer";
    try {
      response = await dio.post(url, data: {
        "email": email,
        "passWord": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "citizenIdentity": citizenIdentity,
        "dateOfBirth": dateOfBirth
      });
      return "Success";
    } on DioException catch (e) {
      return "${e.response}";
    }
  }
}
