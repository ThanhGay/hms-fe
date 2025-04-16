import 'package:android_hms/core/services/api_room.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:android_hms/Entity/mybill.dart';
import 'package:android_hms/core/services/dioClient.dart';
import 'package:android_hms/core/constants/api_constants.dart';

class ApiBill {
  static Future<List<MyBill>> myBooking(BuildContext context) async {
    const String url = "${APIConstants.apiBill}/get-my-booking";
    final uri = Uri.parse(url);

    try {
      print("Callapi bk");
      Response response = await DioClient().dio.getUri(uri);
      print("data return ${response.data['items'][0]}");

      final List<dynamic> items = response.data['items'];

      List<MyBill> bills = items.map((item) => MyBill.fromJson(item)).toList();
      // for (var i = 0; i < bills.length; i++) {
      //   for (var j = 0; j < bills[i].rooms.length; j++) {
      //       final room = await ApiRoom.getRoomById(bills[i].rooms[j].roomID);
      //     bills[i].rooms[j].roomImages = room?.roomImages ?? [];      
      //   }
      // }
      for (var bill in bills) {
        for (var element in bill.rooms) {
          final room = await ApiRoom.getRoomById(element.roomID);
          element.roomImages = room?.roomImages ?? [];
        }
        
      }
      return bills;
    } on DioException catch (e) {
      // In ra mã trạng thái HTTP của response
      throw Exception(
          "Lỗi gọi API my booking: ${e.response?.data}, ${e.response?.statusCode}, ${e.response?.statusMessage}. ${e}");
    }
  }
}
