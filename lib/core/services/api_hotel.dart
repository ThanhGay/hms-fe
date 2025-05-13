import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final dio = Dio();

class ApiHotel {
  static Future<List<Hotel>> dsHotel(
  BuildContext context, {
  String keyword = '',
  bool lowToHigh = false,
  bool highToLow = false,
  bool doubleRoom = false,
  bool singleRoom = false,
}) async {
  Response response;
  const String url = "${APIConstants.api}api/hotel/all";
  List<Hotel> hotels = [];

  // Lấy HotelProvider và RoomProvider trước khi gọi hàm async
  final hotelProvider = Provider.of<HotelProvider>(context, listen: false);
  final roomProvider = Provider.of<RoomProvider>(context, listen: false);

  try {
    response = await dio.get(url);

    List<dynamic> allHotel = response.data['items'];

    hotels = allHotel.map((h) => Hotel.fromJson(h)).toList();
    for (var hotel in hotels) {
      // Truyền roomProvider trực tiếp vào ApiRoom.dsRoom
      final rooms = await ApiRoom.dsRoom(
        roomProvider,
        hotel.hotelId,
        isLowHigh: lowToHigh,
        isHighLow: highToLow,
        isDoubleRoom: doubleRoom,
        isSingleRoom: singleRoom,
        search: keyword,
      );
      hotel.rooms = rooms;
    }

    // Cập nhật HotelProvider
    hotelProvider.setHotels(hotels);

    return hotels;
  } on DioException catch (e) {
    print("Error hotel: $e");
    return hotels;
  }
}

  static Future<Hotel> getHotelById(BuildContext context, int roomId) async {
    Response response;
    final String url = "${APIConstants.api}api/hotel/get/$roomId";
    print("url: ${url}");
    try {
      response = await dio.get(url);

      return Hotel.fromJson(response.data);
    } on DioException catch (e) {
      print("${e.response}");
      return Hotel(
          hotelName: "fail", hotelId: 0, hotelAddress: "fail", hotline: "fail");
    }
  }
}
