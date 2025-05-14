import 'package:json_annotation/json_annotation.dart';

part 'IMyBooking.g.dart';

@JsonSerializable()
class IMyBooking {
  final int? CustomerID;

  IMyBooking({
    required this.CustomerID,
  });

  factory IMyBooking.fromJson(Map<String, dynamic> json) =>
      _$IMyBookingFromJson(json);

  Map<String, dynamic> toJson() => _$IMyBookingToJson(this);
}
