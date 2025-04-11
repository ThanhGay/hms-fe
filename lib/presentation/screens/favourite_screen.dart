import 'package:android_hms/Data/favourite_provider.dart';
import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Entity/favourite.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/services/api_favourite.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/presentation/component/info_room.dart';
import 'package:android_hms/presentation/component/skeletons/info_room_skeleton.dart';
import 'package:android_hms/presentation/component/text_Poppins.dart';
import 'package:android_hms/presentation/screens/room_detail_screen.dart';
import 'package:flutter/material.dart';
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
  bool isLoading = true;

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
      ApiFavourite.favourite(context).then((data) {
        isLoading = false;
      }).catchError((e) {
        isLoading = false;
      });
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
    } else {
      setState(() {
        rooms = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context).hotel;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Danh sách yêu thích",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.4,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton<String>(
              tooltip: 'Chọn khách sạn',
              offset: Offset(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 8,
              onSelected: (selectedHotel) {
                ApiFavourite.favourite(
                  context,
                  selectedHotel.isEmpty ? '' : selectedHotel,
                ).then((data) {
                  setState(() {
                    favoriteItems = data;
                  });
                });
              },
              itemBuilder: (BuildContext context) {
                return [
                  ...hotelProvider.map((hotel) {
                    return PopupMenuItem<String>(
                        value: "${hotel.hotelId}",
                        child: TextPoppins(
                          title: hotel.hotelName,
                          size: 15,
                          color: Colors.grey[800],
                        ));
                  }).toList(),
                  PopupMenuItem<String>(
                      value: '',
                      child: TextPoppins(
                        title: "Tất cả",
                        size: 15,
                        color: Colors.grey[800],
                      )),
                ];
              },
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.filter_list_rounded,
                  color: Colors.blueAccent,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: isLoggedIn
          ? Container(
              child: isLoading
                  ? ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InfoRoomSkeleton();
                      },
                    )
                  : ListView.builder(
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
    );
  }
}
