import 'package:android_hms/models/entities/favourite.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Favourite> _favourite = [];

  List<Favourite> get favourite => _favourite;

  void setFavourite(List<Favourite> data) {
    _favourite = data;
    notifyListeners();
  }
}
