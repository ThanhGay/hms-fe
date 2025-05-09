import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/core/services/api_hotel.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/presentation/component/info_room.dart';
import 'package:android_hms/presentation/component/skeletons/info_room_skeleton.dart';
import 'package:android_hms/presentation/component/text_Poppins.dart';
import 'package:android_hms/presentation/screens/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  int selectedExploreTabIndex = 0;

  List<Room> roomList = [];
  List<Hotel> hotels = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    // Gọi API để lấy danh sách khách sạn
    ApiHotel.dsHotel(context).then((data) {
      setState(() {
        isLoading = false;
        hotels = data;
        roomList = data[0].rooms;
      });
    }).catchError((error) {
      print("Error fetching hotels: $error");
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final prohotel = Provider.of<HotelProvider>(context);
    // List<Hotel> hotels = prohotel.hotel;
    // List<Room> roomList = prohotel.hotel[0].rooms;
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
            children: hotels.map((button) {
              int index = hotels.indexOf(button);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedExploreTabIndex = index;
                    roomList = button.rooms;
                  });
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        scale: selectedExploreTabIndex == index ? 1.25 : 1.0,
                        child: Icon(
                          Icons.hotel,
                          color: selectedExploreTabIndex == index
                              ? getHotelColor(button.hotelName)
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        scale: selectedExploreTabIndex == index ? 1.25 : 1.0,
                        child: TextPoppins(
                          color: selectedExploreTabIndex == index
                              ? getHotelColor(button.hotelName)
                              : Colors.grey,
                          title: button.hotelName,
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 3,
                        width: 60,
                        color: selectedExploreTabIndex == index
                            ? getHotelColor(button.hotelName)
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const Divider(height: 0.5, color: Colors.grey),

        // Danh sách phòng
        Expanded(
          child: isLoading
              ? PageView.builder(
                  itemBuilder: (context, index) {
                    return ListView.builder(
                      itemCount: 5, // số lượng skeleton mỗi trang
                      itemBuilder: (context, _) => InfoRoomSkeleton(),
                    );
                  },
                )
              : PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      selectedExploreTabIndex = index;
                      roomList = hotels[index].rooms;
                    });
                  },
                  itemCount: hotels.length,
                  itemBuilder: (context, index) {
                    final rooms = hotels[index].rooms;
                    return ListView.builder(
                      itemCount: rooms.length,
                      itemBuilder: (context, roomIndex) {
                        final room = rooms[roomIndex];
                        return GestureDetector(
                          onTap: () {
                            print(
                                "RooomId: ${room.roomId} hotelId: ${hotels[index].hotelId}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RoomDetailScreen(
                                  roomId: room.roomId,
                                  hotelId: hotels[index].hotelId,
                                ),
                              ),
                            );
                          },
                          child: InfoRoom(
                            room: room,
                            isLoading: false,
                          ),
                        );
                      },
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
        return Color(0xFF3469FA);
      case 'Eco Green':
        return Color(0xFF00FA17);
      case 'Eco Yellow':
        return Color(0xFFFAB70F);
      default:
        return Colors.black;
    }
  }
}
