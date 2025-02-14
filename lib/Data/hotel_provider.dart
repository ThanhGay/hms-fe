import 'package:flutter/material.dart';

class HotelProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _hotel = [];

  List<Map<String, dynamic>> get hotel => _hotel;

  void setHotels(List<Map<String, dynamic>> data) {
    _hotel = data;
    notifyListeners();
  }
}
