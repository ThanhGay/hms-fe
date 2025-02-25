import 'package:android_hms/core/services/api_hotel.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/presentation/component/info_room.dart';
import 'package:android_hms/presentation/screens/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedExploreTabIndex = 0;

  List<Room> roomList = [];
  List<Hotel> navigationButtons = [];

  @override
  void initState() {
    super.initState();
    // Gọi API để lấy danh sách khách sạn
    ApiHotel.dsHotel(context).then((data) {}).catchError((error) {
      print("Error fetching hotels: $error");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Lấy danh sách khách sạn từ Provider
    final hotelProvider = Provider.of<HotelProvider>(context);
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);

    setState(() {
      navigationButtons = hotelProvider.hotel;

      // Gọi API để lấy danh sách phòng cho khách sạn đầu tiên nếu có
      if (navigationButtons.isNotEmpty) {
        int firstHotelId = navigationButtons[0].hotelId;
        ApiRoom.dsRoom(context, firstHotelId).then((_) {
          setState(() {
            roomList = roomProvider.room;
          });
        }).catchError((error) {
          print("Error fetching rooms: $error");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        // Thanh tìm kiếm
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 5, // Độ cao (bóng)
            borderRadius: BorderRadius.circular(30), // Bo góc
            shadowColor: Colors.black.withOpacity(0.9), // Màu bóng
            child: TextField(
              decoration: InputDecoration(
                filled: true, // Đổ màu nền
                fillColor: Colors.white, // Màu nền
                prefixIcon: const Icon(Icons.search),
                hintText: 'Bắt đầu tìm kiếm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none, // Ẩn viền ngoài
                ),
              ),
            ),
          ),
        ),

        // const Divider(height: 1, color: Colors.grey),

        // Hàng nút điều hướng
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navigationButtons.map((button) {
              int index = navigationButtons.indexOf(button);
              return GestureDetector(
                onTap: () async {
                  int hotelId = button.hotelId;

                  await ApiRoom.dsRoom(context, hotelId);
                  setState(() {
                    selectedExploreTabIndex = index;
                    roomList =
                        Provider.of<RoomProvider>(context, listen: false).room;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.hotel,
                      color: selectedExploreTabIndex == index
                          ? getHotelColor(button.hotelName)
                          : Colors.grey,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      button.hotelName,
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedExploreTabIndex == index
                            ? getHotelColor(button.hotelName)
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 3,
                      width: 60,
                      color: selectedExploreTabIndex == index
                          ? Colors.black // Nếu được chọn thì màu đen
                          : Colors.transparent, // Nếu không thì ẩn đi
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const Divider(height: 0.5, color: Colors.grey),

        // Danh sách phòng
        Expanded(
          child: ListView.builder(
            itemCount: roomList.length,
            itemBuilder: (context, index) {
              final room = roomList[index];

              return GestureDetector(
                onTap: () {
                  if (navigationButtons.isNotEmpty) {
                    int hotelId =
                        navigationButtons[selectedExploreTabIndex].hotelId;
                    String hotelName =
                        navigationButtons[selectedExploreTabIndex].hotelName;
                    // debugPrint("Navigating to RoomDetailScreen");
                    // debugPrint("Room Data: ${room.toString()}");
                    // debugPrint("Hotel ID: ${hotelId}");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomDetailScreen(
                          roomId: room.roomId,
                          hotelId: hotelId,
                          hotelName: hotelName,
                        ),
                      ),
                    );
                  } else {
                    debugPrint("Error: No hotel data available!");
                  }
                },
                child: InfoRoom(room: room),
              );
            },
          ),
        ),
      ],
    );
  }

  // Lấy màu dựa vào tên khách sạn
  Color getHotelColor(String hotelName) {
    switch (hotelName) {
      case 'Eco Blue':
        return Colors.black;
      case 'Eco Green':
        return Colors.black;
      case 'Eco Yellow':
        return Colors.black;
      default:
        return Colors.black;
    }
  }
}
