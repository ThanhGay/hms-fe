import 'package:android_hms/Entity/mybill.dart';
import 'package:android_hms/core/services/Bill/api_myBooking.dart';
import 'package:android_hms/presentation/component/appbar_custom.dart';
import 'package:android_hms/presentation/component/reservation_card.dart';
import 'package:android_hms/presentation/component/skeletons/reservation_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreen();
}

class _TripScreen extends State<TripScreen> {
  bool isLoggedIn = false; // Thêm biến trạng thái
  bool isLoading = true;
  List<MyBill> myBookings = [];

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
      ApiBill.myBooking(context).then((data) {
        isLoading = false;
      }).catchError((e) {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: "Chuyến đi"),
      body: Container(
        child: isLoggedIn
            ? Container(
                child: myBookings.isNotEmpty
                    ? Container(
                        child: isLoading
                            ? ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return ReservationCardSkeleton();
                                })
                            : ListView.builder(
                                itemCount: myBookings.length,
                                itemBuilder: (context, index) {
                                  return ReservationCard(
                                      bill: myBookings[index]);
                                },
                              ))
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn chưa có chuyến đi nào!",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/home'); // Thay bằng route đúng
                              },
                              child: Text("Khám phá"),
                            ),
                          ],
                        ),
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
      ),
    );
  }
}
