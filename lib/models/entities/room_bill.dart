import 'package:json_annotation/json_annotation.dart';
import 'package:android_hms/models/entities/hotel.dart';
import 'package:android_hms/models/dtos/votes/vote_model.dart';

part 'room_bill.g.dart';

@JsonSerializable()
class RoomBill {
  final int roomID;
  final String roomName;
  final int hotelId;
  final int roomTypeId;
  final int floor;
  final double? pricePerNight;
  final double? pricePerHour;
  final String? roomTypeDescription;
  final String? roomTypeName;
  List<Map<String, dynamic>>? roomImages;
  Hotel? _hotelData;
  VoteData? _voteData;

  RoomBill(
      {this.roomImages,
      required this.roomID,
      required this.roomName,
      required this.hotelId,
      required this.roomTypeId,
      required this.floor,
      this.pricePerHour,
      this.pricePerNight,
      this.roomTypeDescription,
      this.roomTypeName});

  factory RoomBill.fromJson(Map<String, dynamic> json) =>
      _$RoomBillFromJson(json);

  Map<String, dynamic> toJson() => _$RoomBillToJson(this);

  Hotel? get hotelData => _hotelData;

  set hotelData(Hotel? hotelData) {
    _hotelData = hotelData;
  }

  VoteData? get voteData => _voteData;

  set voteData(VoteData? voteData) {
    _voteData = voteData;
  }
}
