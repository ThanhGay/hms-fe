import 'dart:convert';

import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiHotel {
  static Future<List<Hotel>> dsHotel(BuildContext context) async {
    const String url = "${GlobalData.api}api/hotel/all";
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      List<Hotel> hotels = [];

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var element in data['items']) {
          hotels.add(Hotel(
              hotelName: element["hotelName"],
              hotelId: element["hotelId"],
              hotelAddress: element['hotelAddress'],
              hotline: element['hotline']));
        }
        List<Map<String, dynamic>> hotelMapList =
            hotels.map((hotel) => hotel.toMap()).toList();

        Provider.of<HotelProvider>(context, listen: false)
            .setHotels(hotelMapList);
      } else {
        print("Lỗi API: ${response.statusCode} - ${response.body}");
      }
      return hotels;
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return [];
    }
  }
}
