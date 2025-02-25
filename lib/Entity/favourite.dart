class Favourite {
  final int favouriteId;
  final int hotelId;
  final int roomId;
  Favourite(
      {required this.favouriteId, required this.hotelId, required this.roomId});

  factory Favourite.fromMap(Map<String, dynamic> map) {
    return Favourite(
        favouriteId: map['favouriteId'] ?? 0,
        hotelId: map['customerId'] ?? 0,
        roomId: map['roomId'] ?? 0);
  }
}
