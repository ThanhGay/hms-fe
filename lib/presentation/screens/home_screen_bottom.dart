import 'package:android_hms/presentation/screens/home_screen.dart';
import 'package:android_hms/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final int age;
  final String address;
  final String email;

  const HomeScreen(
      {Key? key,
      this.avatarUrl = "https://i.imgur.com/BoN9kdC.png",
      this.name = "null",
      this.age = 1,
      this.address = "null",
      this.email = "null"})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomTabIndex = 0; // Chỉ số của Bottom Navigation Bar
  late final List<Widget> mainPages;

  @override
  Widget build(BuildContext context) {
    // Nội dung chính cho từng trang chính của Bottom Navigation Bar
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    print("Hello ${args}");
    final List<Widget> mainPages = [
      const ExplorePage(), // Trang Khám Phá
      Center(child: Text('Trang Thích', style: TextStyle(fontSize: 20))),
      Center(child: Text('Trang Chuyến Đi', style: TextStyle(fontSize: 20))),
      Center(child: Text('Trang Tin Nhắn', style: TextStyle(fontSize: 20))),
      ProfileScreen(
        avatarUrl: widget.avatarUrl,
        address: widget.address,
        age: widget.age,
        email: widget.email,
        name: widget.name,
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
