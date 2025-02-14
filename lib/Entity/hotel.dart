class Hotel {
  final String hotelName;
  final int hotelId;
  final String hotelAddress;
  final String hotline;

  Hotel(
      {required this.hotelName,
      required this.hotelId,
      required this.hotelAddress,
      required this.hotline});

  Map<String, dynamic> toMap() {
    return {
      'hotelName': hotelName,
      'hotelId': hotelId,
      'hotelAddress': hotelAddress,
      'hotline': hotline
    };
  }
}
