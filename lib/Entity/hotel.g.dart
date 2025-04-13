// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      hotelName: json['hotelName'] as String,
      hotelId: (json['hotelId'] as num).toInt(),
      hotelAddress: json['hotelAddress'] as String,
      hotline: json['hotline'] as String,
      rooms: (json['rooms'] as List<dynamic>?)
              ?.map((e) => Room.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'hotelName': instance.hotelName,
      'hotelId': instance.hotelId,
      'hotelAddress': instance.hotelAddress,
      'hotline': instance.hotline,
      'rooms': instance.rooms,
    };
