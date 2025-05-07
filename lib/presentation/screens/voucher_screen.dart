import 'package:android_hms/Entity/voucher.dart';
import 'package:android_hms/core/services/api_voucher.dart';
import 'package:android_hms/presentation/component/appbar_custom.dart';
import 'package:android_hms/presentation/component/skeletons/voucher_card_skeleton.dart';
import 'package:android_hms/presentation/component/voucher_card.dart';
import 'package:android_hms/presentation/utils/toast.dart';
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
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
      try {
        final data = await ApiVoucher.getAllVoucher(context);
        setState(() {
          isLoading = false;
          vouchers = data;
        });
      } catch (err) {
        setState(() {
          isLoading = false;
          errorMessage =
              err is Map ? err['message'] : 'Đã xảy ra lỗi khi tải voucher.';
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text('Lỗi xảy ra khi load vouchers: $errorMessage')),
        // );
        showToast(
          msg: ('Lỗi xảy ra khi load vouchers: $errorMessage'),
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
      }
    } else {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustom(
        title: "Thẻ giảm giá",
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: VoucherCardSkeleton());
                  }),
            );
          } else if (errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage!,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      checkLogin();
                    },
                    child: const Text("Thử lại"),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(20),
              child: isLoggedIn
                  ? vouchers.isEmpty
                      ? const Center(
                          child: Text("Hiện tại không có thẻ giảm giá nào."),
                        )
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
                        )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Bạn chưa đăng nhập!",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text("Đăng nhập"),
                          ),
                        ],
                      ),
                    ),
            );
          }
        },
      ),
    );
  }
}
