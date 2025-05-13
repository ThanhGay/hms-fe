
import 'package:dio/dio.dart';

import 'package:android_hms/core/services/dioClient.dart';
import 'package:android_hms/core/constants/api_constants.dart';

class ApiCancelBill {
  static Future<String> cancelBill(int billId) async {
    Response response;

    final String url = "${APIConstants.apiBill}/delete-booking?bookingId=$billId";
    final uri = Uri.parse(url);

    try {
      response = await DioClient().dio.deleteUri(uri);
      if (response.statusCode == 200) {
        return "Success";
      } else {
        print("${response.data}");
        return "Failed";
      }
    } on DioException catch (e) {
      print("xxx ${e}");
      return ("${e.response}");
    }
  }
}
