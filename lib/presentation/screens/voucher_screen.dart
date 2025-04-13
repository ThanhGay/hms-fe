import 'package:android_hms/Entity/voucher.dart';
import 'package:android_hms/core/services/api_voucher.dart';
import 'package:android_hms/presentation/component/appbar_custom.dart';
import 'package:android_hms/presentation/component/skeletons/voucher_card_skeleton.dart';
import 'package:android_hms/presentation/component/voucher_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});
  @override
  State<StatefulWidget> createState() => _CouponScreen();
}

class _CouponScreen extends State<VoucherScreen> {
  List<Voucher> vouchers = [];
  bool isLoggedIn = false;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement activate
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    // Ví dụ: lấy token từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // hoặc từ Provider
    if (token != null && token.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
      ApiVoucher.getAllVoucher(context).then((data) {
        setState(() {
          isLoading = false;
          vouchers = data;
        });
      }).catchError((e) {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi xảy ra khi: ${e['message']}')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: "Thẻ giảm giá"),
      body: isLoggedIn
          ? Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(20),
              child: isLoading
                  ? ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: VoucherCardSkeleton());
                      })
                  : ListView.builder(
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
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa đăng nhập!",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Chuyển đến trang đăng nhập
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("Đăng nhập"),
                  ),
                ],
              ),
            ),
    );
  }
}
