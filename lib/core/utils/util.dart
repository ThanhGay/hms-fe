import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'package:sprintf/sprintf.dart';

import 'package:android_hms/views/component/payment.dart';

/// Function Format Double to String Currency
String formatCurrency(double value) {
  final formattedNumber = NumberFormat.currency(
          customPattern: "#,###",
          locale: "vi-VN",
          decimalDigits: 0,
          symbol: "đ")
      .format(value);
  return formattedNumber;
}

/// Function Format DateTime to String with pattern string
String formatDateTime(DateTime dateTime, String pattern) {
  return DateFormat(pattern).format(dateTime).toString();
}

int transIdDefault = 1;
String getAppTransId() {
  if (transIdDefault >= 100000) {
    transIdDefault = 1;
  }

  transIdDefault += 1;
  var timeString = formatDateTime(DateTime.now(), "yyMMdd_hhmmss");
  return sprintf("%s%06d", [timeString, transIdDefault]);
}

String getBankCode() => "zalopayapp";
String getDescription(String apptransid) =>
    "Merchant Demo thanh toán cho đơn hàng  #$apptransid";

String getMacCreateOrder(String data) {
  var hmac = new Hmac(sha256, utf8.encode(ZaloPayConfig.key1));
  return hmac.convert(utf8.encode(data)).toString();
}
