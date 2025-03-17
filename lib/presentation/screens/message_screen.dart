import 'package:android_hms/core/services/api_favourite.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreen();
}

class _MessageScreen extends State<MessageScreen> {
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
      appBar: AppBar(
        title: Text("Danh sách tin nhắn"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLoggedIn
                  ? "Bạn chưa có tin nhắn nào!"
                  : "Bạn chưa đăng nhập!",
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