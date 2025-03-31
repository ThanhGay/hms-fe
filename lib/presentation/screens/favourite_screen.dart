import 'package:android_hms/Data/favourite_provider.dart';
import 'package:android_hms/Entity/favourite.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/services/api_favourite.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/presentation/component/info_room.dart';
import 'package:android_hms/presentation/screens/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreen();
}

class _FavouriteScreen extends State<FavouriteScreen> {
  List<Room> rooms = [];
  List<Favourite> favoriteItems = [];
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
      print("Không có token");
      setState(() {
        isLoggedIn = true;
      });
      ApiFavourite.favourite(context).then((data) {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final proFavourite = Provider.of<FavouriteProvider>(context);
    favoriteItems = proFavourite.favourite;
    if (favoriteItems.isNotEmpty) {
      List<Room> roomFav = [];
      for (var element in favoriteItems) {
        ApiRoom.getRoomById(element.roomId).then((data) {
          print("object: ${data}");

          roomFav.add(data!);
          setState(() {
            rooms = roomFav;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách yêu thích",
          style: GoogleFonts.dancingScript(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 10, // đổ bóng
        automaticallyImplyLeading: false,
        shadowColor: Colors.deepOrange, // Màu bóng
      ),
      body: isLoggedIn
          ? ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomDetailScreen(
                          roomId: rooms[index].roomId,
                          hotelId: rooms[index].hotelId,
                        ),
                      ),
                    );
                  },
                  child: InfoRoom(room: rooms[index]),
                );
              },
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
    );
  }
}
