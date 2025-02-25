class Room {
  final int roomId;
  final String roomName;
  final int floor;
  final String roomTypeName;
  final String description;
  final double pricePerHour;
  final double pricePerNight;
  final int roomTypeId;
  final int hotelId;
  final List<dynamic> listImage;
  Room(
      {required this.roomId,
      required this.roomName,
      required this.floor,
      required this.roomTypeName,
      required this.description,
      required this.pricePerHour,
      required this.pricePerNight,
      required this.roomTypeId,
      required this.hotelId,
      required this.listImage});

  factory Room.fromMap(Map<String, dynamic> data) {
    return Room(
        roomId: data['roomId'] ?? 0,
        roomName: data['roomName'] ?? "",
        floor: data['floor'] ?? 0,
        roomTypeName: data['roomTypeName'] ?? '',
        description: data['description'] ?? '',
        pricePerHour: data['pricePerHour'] ?? 0,
        pricePerNight: data['pricePerNight'] ?? 0,
        roomTypeId: data['roomTypeId'] ?? 0,
        hotelId: data['hotelId'] ?? 0,
        listImage: data['roomImages'] ?? []);
  }

  @override
  String toString() {
    return 'Room(roomId: $roomId, roomName: $roomName, floor: $floor, '
        'roomTypeName: $roomTypeName, description: $description, '
        'pricePerHour: $pricePerHour, pricePerNight: $pricePerNight, '
        'roomTypeId: $roomTypeId, hotelId: $hotelId, listImage: $listImage)';
  }
}
