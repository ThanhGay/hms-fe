
import 'package:json_annotation/json_annotation.dart';

part 'room_bill.g.dart';

@JsonSerializable()
class RoomBill {
  final int roomID;
  final String roomName;
  final int hotelId;
  final int roomTypeId;
  final int floor;
  List<Map<String, dynamic>>? roomImages;

  RoomBill(this.roomImages, {required this.roomID, required this.roomName, required this.hotelId, required this.roomTypeId, required this.floor});

  factory RoomBill.fromJson(Map<String, dynamic> json) => _$RoomBillFromJson(json);


  Map<String, dynamic> toJson() => _$RoomBillToJson(this);}
