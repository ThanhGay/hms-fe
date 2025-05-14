import 'package:android_hms/models/entities/room.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  final String hotelName;
  final int hotelId;
  final String hotelAddress;
  final String hotline;
  List<Room> rooms;

  Hotel(
      {required this.hotelName,
      required this.hotelId,
      required this.hotelAddress,
      required this.hotline,
      this.rooms = const []});

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelToJson(this);
}
