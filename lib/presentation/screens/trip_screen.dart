import 'package:android_hms/core/services/api_favourite.dart';
import 'package:android_hms/presentation/component/appbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreen();
}

class _TripScreen extends State<TripScreen> {
  bool isLoggedIn = false; // Thêm biến trạng thái

  @override
  void initState() {
    super.initState();
    checkLogin(); // Kiểm tra đăng nhập
  }

  Future<void> checkLogin() async {
    // Ví dụ: lấy token từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // hoặc từ Provider
    if (token != null && token.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
      ApiFavourite.favourite(context).then((data) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: "Chuyến đi"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLoggedIn ? "Bạn chưa có chuyến đi nào!" : "Bạn chưa đăng nhập!",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (isLoggedIn) {
                  // Chuyển sang trang khám phá
                  Navigator.pushNamed(context, '/home'); // Thay bằng route đúng
                } else {
                  // Chuyển sang trang đăng nhập
                  Navigator.pushNamed(context, '/login');
                }
              },
              child: Text(isLoggedIn ? "Khám phá" : "Đăng nhập"),
            ),
          ],
        ),
      ),
    );
  }
}
