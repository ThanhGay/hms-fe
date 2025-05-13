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
  bool isLoggedIn = false;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
      try {
        await ApiFavourite.favourite(context);
      } catch (e) {
        setState(() {
          errorMessage = "Không thể tải danh sách yêu thích.";
        });
        print("Lỗi tải danh sách yêu thích: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
    }
  }

  Future<void> _loadFavoriteRooms() async {
    setState(() {
      isLoading = true;
      rooms = [];
      errorMessage = null;
    });
    List<Room> tempRooms = [];
    try {
      for (var element in favoriteItems) {
        Room? room = await ApiRoom.getRoomById(element.roomId);
        if (room != null) {
          tempRooms.add(room);
        }
      }
      setState(() {
        rooms = tempRooms;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Không thể tải thông tin phòng yêu thích.";
        print("Lỗi tải thông tin phòng yêu thích: $e");
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final proFavourite = Provider.of<FavouriteProvider>(context);
    if (favoriteItems != proFavourite.favourite) {
      favoriteItems = proFavourite.favourite;
      if (isLoggedIn && favoriteItems.isNotEmpty) {
        _loadFavoriteRooms();
      } else if (!isLoggedIn) {
        setState(() {
          rooms = [];
        });
      } else {
        setState(() {
          rooms = [];
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context).hotel;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/home',
              arguments: {"initialTabIndex": 0},
            );
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
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
              offset: const Offset(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 8,
              onSelected: (selectedHotel) async {
                setState(() {
                  isLoading = true;
                  favoriteItems = [];
                  rooms = [];
                  errorMessage = null;
                });
                try {
                  await ApiFavourite.favourite(
                    context,
                    selectedHotel.isEmpty ? '' : selectedHotel,
                  );
                } catch (e) {
                  setState(() {
                    errorMessage = "Không thể lọc danh sách yêu thích.";
                    print("Lỗi lọc danh sách yêu thích: $e");
                  });
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
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
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.filter_list_rounded,
                  color: Colors.blueAccent,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const InfoRoomSkeleton();
              },
            );
          } else if (errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage!,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (isLoggedIn) {
                        _loadFavoriteRooms();
                      } else {
                        checkLogin();
                      }
                    },
                    child: const Text("Thử lại"),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              alignment: Alignment.topCenter,
              child: isLoggedIn
                  ? rooms.isEmpty
                      ? const Center(
                          child:
                              Text("Danh sách yêu thích của bạn đang trống."),
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
                        )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Bạn chưa đăng nhập!",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text("Đăng nhập"),
                          ),
                        ],
                      ),
                    ),
            );
          }
        },
      ),
    );
  }
}
