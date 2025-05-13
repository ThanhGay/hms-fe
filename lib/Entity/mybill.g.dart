// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mybill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBill _$MyBillFromJson(Map<String, dynamic> json) => MyBill(
      billID: (json['billID'] as num).toInt(),
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      expectedCheckIn: DateTime.parse(json['expectedCheckIn'] as String),
      expectedCheckOut: DateTime.parse(json['expectedCheckOut'] as String),
      checkIn: json['checkIn'] == null
          ? null
          : DateTime.parse(json['checkIn'] as String),
      checkOut: json['checkOut'] == null
          ? null
          : DateTime.parse(json['checkOut'] as String),
      prepayment: (json['prepayment'] as num?)?.toDouble(),
      status: json['status'] as String,
      discountID: (json['discountID'] as num?)?.toDouble(),
      customerID: (json['customerID'] as num?)?.toDouble(),
      receptionistID: (json['receptionistID'] as num?)?.toDouble(),
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => RoomBill.fromJson(e as Map<String, dynamic>))
          .toList(),
      charges: json['charges'] as List<dynamic>?,
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
