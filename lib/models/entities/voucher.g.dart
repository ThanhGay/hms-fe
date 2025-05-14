// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voucher _$VoucherFromJson(Map<String, dynamic> json) => Voucher(
      voucherId: (json['voucherId'] as num).toInt(),
      percent: (json['percent'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      expDate: DateTime.parse(json['expDate'] as String),
      checkUse: json['checkUse'] as bool,
    );

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'voucherId': instance.voucherId,
      'percent': instance.percent,
      'startDate': instance.startDate.toIso8601String(),
      'expDate': instance.expDate.toIso8601String(),
      'checkUse': instance.checkUse,
    };
