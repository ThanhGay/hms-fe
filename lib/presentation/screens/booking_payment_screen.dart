import 'package:flutter/material.dart';
import 'package:android_hms/presentation/component/payment.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPaymentScreen extends StatefulWidget {
  const BookingPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BookingPaymentScreen> createState() => _BookingPaymentScreenState();
}

class _BookingPaymentScreenState extends State<BookingPaymentScreen> {
  String payAmount = "10000";

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
    if (amount < 1000 || amount > 1000000) {
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
                Navigator.pushNamed(context, '/home'); // Chuyển về trang chủ
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
    return Scaffold(
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
              onPressed: () => _createOrder(payAmount),
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
              onPressed: () => _createOrder(payAmount),
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
                "Thanh toán bằng VnPay",
                style: TextStyle(color: Colors.black, fontSize: 16), // Chữ đen
              ),
            ),
            const Spacer(), // Đẩy nội dung còn lại xuống dưới
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Quay lại",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Tiếp theo",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
