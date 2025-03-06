import 'package:json_annotation/json_annotation.dart';

part 'favourite.g.dart';

@JsonSerializable()
class Favourite {
  final int favouriteId;
  final int hotelId;
  final int roomId;

  Favourite(
      {required this.favouriteId, required this.hotelId, required this.roomId});

  factory Favourite.fromJson(Map<String, dynamic> json) =>
      _$FavouriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteToJson(this);
}
