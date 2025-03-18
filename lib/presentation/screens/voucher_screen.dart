import 'package:android_hms/Entity/voucher.dart';
import 'package:android_hms/core/services/api_voucher.dart';
import 'package:android_hms/presentation/component/voucher_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});
  @override
  State<StatefulWidget> createState() => _CouponScreen();
}

class _CouponScreen extends State<VoucherScreen> {
  List<Voucher> vouchers = [];

  @override
  void initState() {
    // TODO: implement activate
    super.initState();
    ApiVoucher.getAllVoucher(context).then((data) {
      setState(() {
        vouchers = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thẻ Giảm Giá",
          style: GoogleFonts.dancingScript(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 10, // đổ bóng
        automaticallyImplyLeading: false,
        shadowColor: Colors.deepOrange, // Màu bóng
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: vouchers.length,
          itemBuilder: (context, index) {
            final voucher = vouchers[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: VoucherCard(
                  discount: "${voucher.percent}%",
                  code: "${voucher.voucherId}",
                  expiryDate: voucher.expDate),
            );
          },
        ),
      ),
    );
  }
}
