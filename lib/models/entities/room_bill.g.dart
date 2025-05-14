// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomBill _$RoomBillFromJson(Map<String, dynamic> json) => RoomBill(
      roomImages: (json['roomImages'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      roomID: (json['roomID'] as num).toInt(),
      roomName: json['roomName'] as String,
      hotelId: (json['hotelId'] as num).toInt(),
      roomTypeId: (json['roomTypeId'] as num).toInt(),
      floor: (json['floor'] as num).toInt(),
      pricePerHour: (json['pricePerHour'] as num?)?.toDouble(),
      pricePerNight: (json['pricePerNight'] as num?)?.toDouble(),
      roomTypeDescription: json['roomTypeDescription'] as String?,
      roomTypeName: json['roomTypeName'] as String?,
    );

Map<String, dynamic> _$RoomBillToJson(RoomBill instance) => <String, dynamic>{
      'roomID': instance.roomID,
      'roomName': instance.roomName,
      'hotelId': instance.hotelId,
      'roomTypeId': instance.roomTypeId,
      'floor': instance.floor,
      'pricePerNight': instance.pricePerNight,
      'pricePerHour': instance.pricePerHour,
      'roomTypeDescription': instance.roomTypeDescription,
      'roomTypeName': instance.roomTypeName,
      'roomImages': instance.roomImages,
    };
