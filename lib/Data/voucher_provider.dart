import 'package:android_hms/Entity/voucher.dart';
import 'package:flutter/material.dart';

class VoucherProvider extends ChangeNotifier {
  List<Voucher> _voucher = [];
  List<Voucher> get voucher => _voucher;
  void setVoucher(List<Voucher> data) {
    _voucher = data;
    notifyListeners();
  }
}
