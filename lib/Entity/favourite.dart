import 'package:flutter/foundation.dart';

class Favourite {
  final int favouriteId;
  final int customerId;
  final int roomId;

  Favourite(
      {required this.favouriteId,
      required this.customerId,
      required this.roomId});

  factory Favourite.fromMap(Map<String, dynamic> map) {
    return Favourite(
        favouriteId: map['favouriteId'] ?? 0,
        customerId: map['customerId'] ?? 0,
        roomId: map['roomId'] ?? 0);
  }
}
