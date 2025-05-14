import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
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
  final List<Map<String, dynamic>> roomImages;
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
      required this.roomImages});

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
