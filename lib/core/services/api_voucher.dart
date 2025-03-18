import 'package:android_hms/Data/voucher_provider.dart';
import 'package:android_hms/Entity/voucher.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/core/services/dioClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiVoucher {
  static Future<List<Voucher>> getAllVoucher(BuildContext context) async {
    Response response;
    final String url = "${APIConstants.api}get-all-voucher-customer";
    List<Voucher> vouchers = [];
    try {
      response = await DioClient().dio.get(url);

      List<dynamic> allVoucher = response.data['items'];

      vouchers = allVoucher.map((r) => Voucher.fromJson(r)).toList();

      Provider.of<VoucherProvider>(context, listen: false);

      return vouchers;
    } on DioException catch (e) {
      print("Error voucher: ${e.response}");
      return vouchers;
    }
  }
}
