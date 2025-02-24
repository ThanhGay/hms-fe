class Hotel {
  final String hotelName;
  final int hotelId;
  final String hotelAddress;
  final String hotline;

  Hotel({
    required this.hotelName,
    required this.hotelId,
    required this.hotelAddress,
    required this.hotline,
  });

  // Chuyển từ Map -> Hotel
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      hotelName: map['hotelName'] ?? '',
      hotelId: map['hotelId'] ?? 0,
      hotelAddress: map['hotelAddress'] ?? '',
      hotline: map['hotline'] ?? '',
    );
  }
}
