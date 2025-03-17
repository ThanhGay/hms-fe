import 'package:android_hms/Entity/room.dart';
import 'package:flutter/material.dart';

class RoomProvider extends ChangeNotifier {
  List<Room> _room = [];

  List<Room> get room => _room;

  void setRooms(List<Room> data) {
    _room = data;
    notifyListeners();
  }
}
