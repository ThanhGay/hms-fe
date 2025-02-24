import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final dio = Dio();

class ApiHotel {
  static Future<List<Hotel>> dsHotel(BuildContext context) async {
    Response response;
    const String url = "${APIConstants.api}api/hotel/all";
    List<Hotel> hotels = [];

    try {
      response = await dio.get(url);

      List<dynamic> allHotel = response.data['items'];

      hotels = allHotel.map((h) => Hotel.fromJson(h)).toList();

      Provider.of<HotelProvider>(context, listen: false).setHotels(hotels);

      return hotels;
    } on DioException catch (e) {
      print("Lỗi khi gọi API: $e");
      return hotels;
    }
  }
}
