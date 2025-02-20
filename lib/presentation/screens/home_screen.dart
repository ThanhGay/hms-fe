import 'package:android_hms/core/services/api_hotel.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/presentation/component/info_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedExploreTabIndex = 0;

  // Dữ liệu mẫu cho danh sách phòng hiện tại
  List<Room> roomList = [];
  List<Hotel> navigationButtons = [];

  // Danh sách nút điều hướng
  @override
  void initState() {
    super.initState();
    ApiHotel.dsHotel(context).then((data) {}).catchError((error) {
      print("error: ${error}");
    });
    print("object");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Truy cập vào HotelProvider tại đây thay vì trong initState.
    setState(() {
      navigationButtons = Provider.of<HotelProvider>(context).hotel;
      ApiRoom.dsRoom(context, 2).then((data) {}).catchError((error) {
        print("error: ${error}");
      });
      roomList = Provider.of<RoomProvider>(context, listen: false).room;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // Thanh tìm kiếm
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Tìm kiếm...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        const Divider(height: 1, color: Colors.grey),

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
                          : Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      button.hotelName,
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedExploreTabIndex == index
                            ? getHotelColor(button.hotelName)
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const Divider(height: 1, color: Colors.grey),

        // Danh sách phòng
        Expanded(
          child: ListView.builder(
            itemCount: roomList.length,
            itemBuilder: (context, index) {
              final room = roomList[index];
              return InfoRoom(room: room);
            },
          ),
        ),
      ],
    );
  }

  Color getHotelColor(String hotelName) {
    switch (hotelName) {
      case 'Eco Blue':
        return Colors.blue;
      case 'Eco Green':
        return Colors.green;
      case 'Eco Yellow':
        return Colors.yellow;
      default:
        return Colors.blue;
    }
  }
  // Future<void> loadData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? jsonData = prefs.getString('userData');
  //   Map<String, dynamic> user = json.decode(jsonData!); // Chuyển lại thành Map
  //   print('Data ${user['firstName']} ${user['lastName']}');
  // }
}
