
import 'package:android_hms/services/Auth/api_vnpay.dart';
import 'package:android_hms/core/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:android_hms/views/component/payment.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:uni_links/uni_links.dart';
import 'dart:async';

class BookingPaymentScreen extends StatefulWidget {
  final int roomId;
  final int hotelId;
  final String totalPrice;

  const BookingPaymentScreen(
      {super.key,
      required this.roomId,
      required this.hotelId,
      required this.totalPrice});

  @override
  State<BookingPaymentScreen> createState() => _BookingPaymentScreenState();
}

class _BookingPaymentScreenState extends State<BookingPaymentScreen> {

  Future<void> _openOrderUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Không thể mở URL: $url');
    }
  }

  Future<void> _createOrder(String value) async {
    int amount = int.parse(value);
    if (amount < 1000 || amount > 100000000) {
      print("Invalid Amount");
    } else {
      showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      var result = await createOrder(amount);
      Navigator.pop(context);

      if (result != null) {
        _openOrderUrl(result.orderurl);

        // Sau 5s hiển thị thông báo thành công
        Future.delayed(const Duration(seconds: 5), () {
          _showSuccessDialog();
        });
      }
    }
  }

  Future<void> _vnpay(String value) async {
    int orderId = DateTime.now().millisecondsSinceEpoch;
    double amount = double.parse(value);
    String orderDesc = "Thanh toán vnpay";
    String orderType = "vnpay";

    final response =
        await ApiVnpay.Vnpay(orderId, amount, orderDesc, orderType);

    if (response.startsWith("https")) {
      // Mở link thanh toán
      final uri = Uri.parse(response);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      // Có thể thêm delay hoặc điều hướng tiếp
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushNamed(
          context,
          '/home',
          arguments: {"initialTabIndex": 0},
        );
      });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Tạo đơn thanh toán thất bại!')),
      // );
      showToast(
        msg: ("Tạo đơn thanh toán thất bại!"),
        backgroundColor: Colors.red,
        textColor: Colors.white);

    }
  }

  // Hộp thoại thông báo thành công
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Người dùng phải ấn nút để đóng
      builder: (context) {
        return AlertDialog(
          title: const Text("Thanh toán thành công"),
          content: const Text("Cảm ơn bạn đã thanh toán!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng hộp thoại
                Navigator.pushNamed(
                  context,
                  '/home',
                  arguments: {"initialTabIndex": 0},
                ); // Chuyển về trang chủ
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Lùi 1 lần
        Navigator.pop(context); // Lùi thêm 1 lần nữa
        return false; // Ngăn Flutter pop mặc định
      },
      child: Scaffold(
      appBar: AppBar(
        title: const Text("Thanh toán"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _createOrder(widget.totalPrice),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Nền trắng
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.black), // Viền đen
                ),
              ),
              child: const Text(
                "Thanh toán bằng Zalo Pay",
                style: TextStyle(color: Colors.black, fontSize: 16), // Chữ đen
              ),
            ),
            SizedBox(
              height: 14,
            ),
            ElevatedButton(
              onPressed: () => _vnpay(widget.totalPrice),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Nền trắng
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.black), // Viền đen
                ),
              ),
              child: Text(
                "  Thanh toán bằng VnPay  ",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            const Spacer(), // Đẩy nội dung còn lại xuống dưới
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      ),
    );
  }
}
