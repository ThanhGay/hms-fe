import 'package:flutter/material.dart';

class RoomProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _room = [];

  List<Map<String, dynamic>> get room => _room;

  void setHotels(List<Map<String, dynamic>> data) {
    _room = data;
    notifyListeners();
  }
}
