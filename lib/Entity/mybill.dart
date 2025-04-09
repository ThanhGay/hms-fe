import 'package:android_hms/Entity/room.dart';

import 'package:json_annotation/json_annotation.dart';

part 'mybill.g.dart';

@JsonSerializable()
class MyBill {
  final int billID;
  final DateTime bookingDate;
  final DateTime expectedCheckIn;
  final DateTime expectedCheckOut;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final double prepayment;
  final String status;
  final int? discountID;
  final int? customerID;
  final int? receptionistID;
  final List<Room> rooms;
  final int? charges;

  MyBill(
      this.billID,
      this.bookingDate,
      this.expectedCheckIn,
      this.expectedCheckOut,
      this.checkIn,
      this.checkOut,
      this.prepayment,
      this.status,
      this.discountID,
      this.customerID,
      this.receptionistID,
      this.rooms,
      this.charges);

  factory MyBill.fromJson(Map<String, dynamic> json) => _$MyBillFromJson(json);

  Map<String, dynamic> toJson() => _$MyBillToJson(this);
}
