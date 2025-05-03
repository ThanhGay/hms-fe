import 'package:android_hms/core/services/chat_service.dart';
import 'package:android_hms/presentation/screens/chat_screen.dart';
import 'package:android_hms/presentation/screens/voucher_screen.dart';
import 'package:android_hms/presentation/screens/favourite_screen.dart';
import 'package:android_hms/presentation/screens/home_screen.dart';
import 'package:android_hms/presentation/screens/profile_screen.dart';
import 'package:android_hms/presentation/screens/trip_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenBottom extends StatefulWidget {
  final int initialTabIndex; // thêm thuộc tính mới

  const HomeScreenBottom({Key? key, this.initialTabIndex = 0})
      : super(key: key);

  @override
  State<HomeScreenBottom> createState() => _HomeScreenBottomState();
}

class _HomeScreenBottomState extends State<HomeScreenBottom> {
  final ChatService chatService = ChatService();

  late int selectedBottomTabIndex;
  int unreadMessageCount = 4;
  String conversationId = 'Receptionist';
  @override
  void initState() {
    super.initState();

    selectedBottomTabIndex = widget.initialTabIndex; // lấy giá trị từ widget
    _loadUnReadMessage();
  }

  Future<void> _loadUnReadMessage() async {
    final prefs = await SharedPreferences.getInstance();
    String? convId = prefs.getString('conversationId');
    setState(() {
      if (convId != null) {
        conversationId = convId;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> mainPages = [
      const HomeScreen(),
      FavouriteScreen(),
      VoucherScreen(),
      TripScreen(),
      ChatScreen(),
      ProfileScreen()
    ];

    return Scaffold(
      body: mainPages[selectedBottomTabIndex],
      bottomNavigationBar: StreamBuilder<int>(
        stream: chatService.getUnreadMessageCountStream(conversationId),
        builder: (context, snapshot) {
          final unreadMessageCount = snapshot.data ?? 0;
          return BottomNavigationBar(
            currentIndex: selectedBottomTabIndex,
            onTap: (index) {
              setState(
                () {
                  selectedBottomTabIndex = index;
                },
              );
            },
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Khám phá'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline), label: 'Yêu thích'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard_outlined), label: 'Giảm giá'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.airplane_ticket_outlined),
                  label: 'Chuyến đi'),
              BottomNavigationBarItem(
                  icon: badges.Badge(
                    showBadge: unreadMessageCount > 0,
                    badgeContent: Text(
                      unreadMessageCount.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    child: Icon(Icons.message_outlined),
                    badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                  ),
                  label: "Tin nhắn"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'Hồ Sơ'),
            ],
          );
        },
      ),
    );
  }
}
