import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/screens/home_screen.dart';
import 'package:android_hms/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomTabIndex = 0; // Chỉ số của Bottom Navigation Bar
  late final List<Widget> mainPages;

  @override
  Widget build(BuildContext context) {
    // Nội dung chính cho từng trang chính của Bottom Navigation Bar
    final List<Widget> mainPages = [
      const ExplorePage(), // Trang Khám Phá
      Center(child: Text('Trang Thích', style: TextStyle(fontSize: 20))),
      Center(child: Text('Trang Chuyến Đi', style: TextStyle(fontSize: 20))),
      Center(child: Text('Trang Tin Nhắn', style: TextStyle(fontSize: 20))),
      ProfileScreen(
        user: widget.user,
      )
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
