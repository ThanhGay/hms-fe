// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mybill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBill _$MyBillFromJson(Map<String, dynamic> json) => MyBill(
      (json['billID'] as num).toInt(),
      DateTime.parse(json['bookingDate'] as String),
      DateTime.parse(json['expectedCheckIn'] as String),
      DateTime.parse(json['expectedCheckOut'] as String),
      json['checkIn'] == null
          ? null
          : DateTime.parse(json['checkIn'] as String),
      json['checkOut'] == null
          ? null
          : DateTime.parse(json['checkOut'] as String),
      (json['prepayment'] as num).toDouble(),
      json['status'] as String,
      (json['discountID'] as num?)?.toInt(),
      (json['customerID'] as num?)?.toInt(),
      (json['receptionistID'] as num?)?.toInt(),
      (json['rooms'] as List<dynamic>)
          .map((e) => Room.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['charges'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MyBillToJson(MyBill instance) => <String, dynamic>{
      'billID': instance.billID,
      'bookingDate': instance.bookingDate.toIso8601String(),
      'expectedCheckIn': instance.expectedCheckIn.toIso8601String(),
      'expectedCheckOut': instance.expectedCheckOut.toIso8601String(),
      'checkIn': instance.checkIn?.toIso8601String(),
      'checkOut': instance.checkOut?.toIso8601String(),
      'prepayment': instance.prepayment,
      'status': instance.status,
      'discountID': instance.discountID,
      'customerID': instance.customerID,
      'receptionistID': instance.receptionistID,
      'rooms': instance.rooms,
      'charges': instance.charges,
    };
