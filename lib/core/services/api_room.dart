import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final dio = Dio();

class ApiRoom {
  static Future<List<Room>> dsRoom(BuildContext context, int hotelId) async {
    Response response;
    final String url = "${APIConstants.api}api/room/all?hotelId=$hotelId";
    List<Room> rooms = [];

    try {
      response = await dio.get(url);

      List<dynamic> allRoombyId = response.data['items'];

      rooms = allRoombyId.map((r) => Room.fromJson(r)).toList();

      Provider.of<RoomProvider>(context, listen: false).setRooms(rooms);

      return rooms;
    } on DioException catch (e) {
      print("Error room: ${e.response}");
      print("${e.response}");
      return rooms;
    }
  }

  static Future<Room> getRoomById(BuildContext context, int roomId) async {
    Response response;
    final String url = "${APIConstants.api}api/room/get/$roomId";
    try {
      response = await dio.get(url);

      return Room.fromJson(response.data);
    } on DioException catch (e) {
      print("${e.response}");
      return Room(
          roomId: 0,
          roomName: "fail",
          floor: 0,
          roomTypeName: "fail",
          description: "fail",
          pricePerHour: 0,
          pricePerNight: 0,
          roomTypeId: 0,
          hotelId: 0,
          roomImages: []);
    }
  }
}
