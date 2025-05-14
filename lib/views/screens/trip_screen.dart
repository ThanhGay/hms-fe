import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:android_hms/models/entities/mybill.dart';
import 'package:android_hms/services/Bill/api_myBooking.dart';

import 'package:android_hms/views/component/appbar_custom.dart';
import 'package:android_hms/views/component/reservation_card.dart';
import 'package:android_hms/views/component/skeletons/reservation_card_skeleton.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreen();
}

class _TripScreen extends State<TripScreen> {
  bool isLoggedIn = false;
  bool isLoading = true;
  List<MyBill> myBookings = [];

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      print("Token: $token");

      setState(() {
        isLoggedIn = true;
      });

      ApiBill.myBooking(context).then((data) {
        setState(() {
          print("API trả về dữ liệu: ${data[0].rooms[0].roomImages}");
          myBookings = data;
          isLoading = false;
        });
        print("Fetched bookings: ${myBookings[0].rooms[0].roomImages}");
      }).catchError((e) {
        setState(() {
          isLoading = false;
          print("Lỗi khi gọi API my-booking: $e");
        });
      });
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
        appBar: AppbarCustom(title: "Chuyến đi"),
        body: isLoading
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ReservationCardSkeleton();
                })
            : Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(8),
                child: isLoggedIn
                    ? Container(
                        child: myBookings.isNotEmpty
                            ? ListView.builder(
                                itemCount: myBookings.length,
                                itemBuilder: (context, index) {
                                  return ReservationCard(
                                      bill: myBookings[index]);
                                },
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Bạn chưa có chuyến đi nào!",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/home',
                                          arguments: {"initialTabIndex": 0},
                                        );
                                      },
                                      child: Text("Khám phá"),
                                    ),
                                  ],
                                ),
                              ))
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn chưa đăng nhập!",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text("Đăng nhập"),
                            ),
                          ],
                        ),
                      )));
  }
}
