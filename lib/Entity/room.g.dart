// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      roomId: (json['roomId'] as num).toInt(),
      roomName: json['roomName'] as String,
      floor: (json['floor'] as num).toInt(),
      roomTypeName: json['roomTypeName'] as String,
      description: json['description'] as String,
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      roomTypeId: (json['roomTypeId'] as num).toInt(),
      hotelId: (json['hotelId'] as num).toInt(),
      roomImages: (json['roomImages'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [], // Trả về danh sách rỗng nếu null
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'floor': instance.floor,
      'roomTypeName': instance.roomTypeName,
      'description': instance.description,
      'pricePerHour': instance.pricePerHour,
      'pricePerNight': instance.pricePerNight,
      'roomTypeId': instance.roomTypeId,
      'hotelId': instance.hotelId,
      'listImage': instance.roomImages,
    };
