import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/core/services/dioClient.dart';
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

      rooms = allRoombyId.map((r) => Room.fromMap(r)).toList();

      Provider.of<RoomProvider>(context, listen: false).setRooms(rooms);

      return rooms;
    } on DioException catch (e) {
      print("Error room: ${e.response}");
      return rooms;
    }
  }

  static Future<Room> RoomById(BuildContext context, int RoomId) async {
    Response response;
    final String url = "${APIConstants.api}api/room/get/$RoomId";
    Room? room;

    try {
      response = await DioClient().dio.get(url);

      dynamic roomData = response.data;

      room = Room.fromMap(roomData);

      return room;
    } on DioException catch (e) {
      print("Error room by id: ${e.response}");
      return room!;
    }
  }
}
