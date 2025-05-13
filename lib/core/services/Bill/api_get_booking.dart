import 'package:dio/dio.dart';
import 'package:android_hms/core/services/dioClient.dart';
import 'package:android_hms/core/services/api_hotel.dart';
import 'package:android_hms/core/services/api_view_vote.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/Entity/mybill.dart';

class ApiBill {
  static Future<MyBill> detailBill(int billId) async {
    final String url = "${APIConstants.apiBill}/get-booking/$billId";
    final uri = Uri.parse(url);

    try {
      Response response = await DioClient().dio.getUri(uri);

      MyBill bill = MyBill.fromJson(response.data);

      for (var element in bill.rooms) {
        final room = await ApiRoom.getRoomById(element.roomID);
        element.roomImages = room?.roomImages ?? [];

        final hotelData = await ApiHotel.getHotelById(element.hotelId);
        element.hotelData = hotelData;

        final voteData = await ApiViewVote.viewVote(element.roomID);
        element.voteData = voteData;
      }

      return bill;
    } on DioException catch (e) {
      // In ra mã trạng thái HTTP của response
      throw Exception(
          "Lỗi gọi API get-booking: ${e.response?.data}, ${e.response?.statusCode}, ${e.response?.statusMessage}. $e");
    }
  }
}
