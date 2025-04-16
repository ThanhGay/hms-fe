// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomBill _$RoomBillFromJson(Map<String, dynamic> json) => RoomBill(
      (json['roomImages'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      roomID: (json['roomID'] as num).toInt(),
      roomName: json['roomName'] as String,
      hotelId: (json['hotelId'] as num).toInt(),
      roomTypeId: (json['roomTypeId'] as num).toInt(),
      floor: (json['floor'] as num).toInt(),
    );

Map<String, dynamic> _$RoomBillToJson(RoomBill instance) => <String, dynamic>{
      'roomID': instance.roomID,
      'roomName': instance.roomName,
      'hotelId': instance.hotelId,
      'roomTypeId': instance.roomTypeId,
      'floor': instance.floor,
      'roomImages': instance.roomImages,
    };
