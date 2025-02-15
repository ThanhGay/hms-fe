import 'package:android_hms/Entity/hotel.dart';
import 'package:flutter/material.dart';

class HotelProvider extends ChangeNotifier {
  List<Hotel> _hotel = [];

  List<Hotel> get hotel => _hotel;

  void setHotels(List<Hotel> data) {
    _hotel = data;
    notifyListeners();
  }
}
