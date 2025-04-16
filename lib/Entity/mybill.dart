import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/Entity/room_bill.dart';

import 'package:json_annotation/json_annotation.dart';

part 'mybill.g.dart';

@JsonSerializable()
class MyBill {
  final double billID;
  final DateTime bookingDate;
  final DateTime expectedCheckIn;
  final DateTime expectedCheckOut;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final double? prepayment;
  final String status;
  final double? discountID;
  final double? customerID;
  final double? receptionistID;
  final List<RoomBill> rooms;
  final double? charges;

  MyBill({required this.billID, required this.bookingDate, required this.expectedCheckIn, required this.expectedCheckOut, required this.checkIn, required this.checkOut, required this.prepayment, required this.status, required this.discountID, required this.customerID, required this.receptionistID, required this.rooms, required this.charges});
  factory MyBill.fromJson(Map<String, dynamic> json) => _$MyBillFromJson(json);


  Map<String, dynamic> toJson() => _$MyBillToJson(this);
}
