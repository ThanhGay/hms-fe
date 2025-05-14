import 'package:json_annotation/json_annotation.dart';

part 'voucher.g.dart';

@JsonSerializable()
class Voucher {
  final int voucherId;
  final int percent;
  final DateTime startDate;
  final DateTime expDate;
  final bool checkUse;

  Voucher({
    required this.voucherId,
    required this.percent,
    required this.startDate,
    required this.expDate,
    required this.checkUse,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherToJson(this);
}
