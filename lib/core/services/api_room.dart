import 'dart:convert';

import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiRoom {
  static Future<List<Room>> dsRoom(BuildContext context, int hotelId) async {
    final String url = "${APIConstants.api}api/room/all?hotelId=$hotelId";
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      List<Room> rooms = [];
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var element in data['items']) {
          List<Map<String, dynamic>> listImage =
              List<Map<String, dynamic>>.from(element['roomImages']);
          rooms.add(Room(
              roomId: element['roomId'],
              roomName: element['roomName'],
              floor: element['floor'],
              roomTypeName: element['roomTypeName'],
              description: element['description'],
              pricePerHour: element['pricePerHour'],
              pricePerNight: element['pricePerNight'],
              roomTypeId: element['roomTypeId'],
              hotelId: element['hotelId'],
              listImage: listImage));
        }
        Provider.of<RoomProvider>(context, listen: false).setHotels(rooms);
      } else {
        print("Lỗi API: ${response.statusCode} - ${response.body}");
      }
      return rooms;
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return [];
    }
  }
}
