import 'dart:convert';

import 'package:android_hms/Entity/Hotel.dart';
import 'package:android_hms/GlobalData.dart';
import 'package:http/http.dart' as http;

class ApiHotel {
  static Future<List<Hotel>> dsHotel() async {
    const String url = "${GlobalData.api}api/hotel/all";
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      List<Hotel> hotels = [];

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var element in data['items']) {
          hotels.add(Hotel(
              hotelName: element['hotelName'], hotelId: element['hotelId']));
        }
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
