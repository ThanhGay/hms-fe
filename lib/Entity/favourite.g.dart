// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favourite _$FavouriteFromJson(Map<String, dynamic> json) => Favourite(
      favouriteId: (json['favouriteId'] as num).toInt(),
      customerId: (json['customerId'] as num).toInt(),
      roomId: (json['roomId'] as num).toInt(),
    );

Map<String, dynamic> _$FavouriteToJson(Favourite instance) => <String, dynamic>{
      'favouriteId': instance.favouriteId,
      'customerId': instance.customerId,
      'roomId': instance.roomId,
    };
