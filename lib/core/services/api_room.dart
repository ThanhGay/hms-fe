import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final dio = Dio();

class ApiRoom {
  static Future<List<Room>> dsRoom(
    BuildContext context,
    int hotelId, {
    required bool isLowHigh,
    required bool isHighLow,
    required bool isDoubleRoom,
    required bool isSingleRoom,
    String search = '',
  }) async {
     print('--- dsRoom Called ---');
      print('hotelId: $hotelId');
      print('isLowHigh: $isLowHigh');
      print('isHighLow: $isHighLow');
      print('isDoubleRoom: $isDoubleRoom');
      print('isSingleRoom: $isSingleRoom');
      print('search: $search');
    Response response;
    final String url =
        "${APIConstants.api}api/room/all?hotelId=$hotelId&isHighLow=$isHighLow&isLowHigh=$isLowHigh&Search=$search&isDoubleRoom=$isDoubleRoom&isSingleRoom=$isSingleRoom";

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

  static Future<Room?> getRoomById(int roomId) async {
    Response response;
    final String url = "${APIConstants.api}api/room/get/$roomId";
    try {
      response = await dio.get(url);

      return Room.fromJson(response.data);
    } on DioException catch (e) {
      print("${e.response}");
      return null;
    }
  }
}
