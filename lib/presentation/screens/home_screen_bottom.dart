import 'package:android_hms/presentation/screens/chat_screen.dart';
import 'package:android_hms/presentation/screens/voucher_screen.dart';
import 'package:android_hms/presentation/screens/favourite_screen.dart';
import 'package:android_hms/presentation/screens/home_screen.dart';
import 'package:android_hms/presentation/screens/profile_screen.dart';
import 'package:android_hms/presentation/screens/trip_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenBottom extends StatefulWidget {
  const HomeScreenBottom({Key? key}) : super(key: key);

  @override
  State<HomeScreenBottom> createState() => _HomeScreenBottomState();
}

class _HomeScreenBottomState extends State<HomeScreenBottom> {
  int selectedBottomTabIndex = 0; // Chỉ số của Bottom Navigation Bar
  late final List<Widget> mainPages;

  @override
  Widget build(BuildContext context) {
    // Nội dung chính cho từng trang chính của Bottom Navigation Bar
    final List<Widget> mainPages = [
      const HomeScreen(), // Trang Khám Phá
      FavouriteScreen(),
      VoucherScreen(),
      TripScreen(),
      ChatScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      body: mainPages[selectedBottomTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedBottomTabIndex,
        onTap: (index) {
          setState(() {
            selectedBottomTabIndex = index;
          });
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            label: 'Giảm giá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Chuyến đi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Hồ Sơ',
          ),
        ],
      ),
    );
  }
}
