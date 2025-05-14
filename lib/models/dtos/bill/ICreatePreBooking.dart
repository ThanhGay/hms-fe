import 'package:json_annotation/json_annotation.dart';

part 'ICreatePreBooking.g.dart';

@JsonSerializable()
class ICreatePreBooking {
  final DateTime BookingDate;
  final DateTime ExpectedCheckIn;
  final DateTime ExpectedCheckOut;
  final String Status;
  final int? DiscountID;
  final int CustomerID;
  final List<int> RoomIds;

  ICreatePreBooking(
      {required this.BookingDate,
      required this.ExpectedCheckIn,
      required this.ExpectedCheckOut,
      this.Status = "PreBooking",
      required this.DiscountID,
      required this.CustomerID,
      required this.RoomIds});

  factory ICreatePreBooking.fromJson(Map<String, dynamic> json) =>
      _$ICreatePreBookingFromJson(json);

  Map<String, dynamic> toJson() => _$ICreatePreBookingToJson(this);
}
