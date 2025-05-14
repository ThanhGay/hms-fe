import 'package:android_hms/models/dtos/bill/ICreatePreBooking.dart';
import 'package:dio/dio.dart';

import 'package:android_hms/services/dioClient.dart';
import 'package:android_hms/core/constants/api_constants.dart';

class ApiBill {
  static Future<String> createPreBil(ICreatePreBooking dto) async {
    Response response;

    const String url = "${APIConstants.apiBill}/create-pre-booking";
    final uri = Uri.parse(url);

    try {
      response = await DioClient().dio.postUri(uri, data: dto.toJson());
      return response.data['message'];
      
    } on DioException catch (e) {
      return ("${e.response}");
    }
  }
}
