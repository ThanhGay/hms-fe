// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ICreatePreBooking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ICreatePreBooking _$ICreatePreBookingFromJson(Map<String, dynamic> json) =>
    ICreatePreBooking(
      BookingDate: DateTime.parse(json['BookingDate'] as String),
      ExpectedCheckIn: DateTime.parse(json['ExpectedCheckIn'] as String),
      ExpectedCheckOut: DateTime.parse(json['ExpectedCheckOut'] as String),
      Status: json['Status'] as String? ?? "PreBooking",
      DiscountID: (json['DiscountID'] as num?)?.toInt(),
      CustomerID: (json['CustomerID'] as num).toInt(),
      RoomIds: (json['RoomIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$ICreatePreBookingToJson(ICreatePreBooking instance) =>
    <String, dynamic>{
      'BookingDate': instance.BookingDate.toIso8601String(),
      'ExpectedCheckIn': instance.ExpectedCheckIn.toIso8601String(),
      'ExpectedCheckOut': instance.ExpectedCheckOut.toIso8601String(),
      'Status': instance.Status,
      'DiscountID': instance.DiscountID,
      'CustomerID': instance.CustomerID,
      'RoomIds': instance.RoomIds,
    };
