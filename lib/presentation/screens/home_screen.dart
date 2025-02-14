import 'package:android_hms/Api/api_hotel.dart';
import 'package:android_hms/Api/api_room.dart';
import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int selectedExploreTabIndex = 0;

  // Dữ liệu mẫu cho danh sách phòng hiện tại
  List<Map<String, dynamic>> roomList = [];
  List<Map<String, dynamic>> navigationButtons = [];

  // Danh sách nút điều hướng
  @override
  void initState() {
    super.initState();
    // Khởi tạo roomList với dữ liệu của tab đầu tiên
    // DsHotel().then((data) {
    //   int hotelId = navigationButtons[0]['hotelId'];
    //   DsRoom(hotelId).then((data) {}).catchError((error) {});
    // }).catchError((error) {
    //   print("Lỗi");
    // });
    ApiHotel.dsHotel(context).then((data) {}).catchError((error) {
      print("error: ${error}");
    });
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
                  int hotelId = button['hotelId'];

                  await ApiRoom.dsRoom(context, hotelId);
                  setState(() {
                    selectedExploreTabIndex = index;
                    // roomList =
                    //     exploreTabData[index]; // Cập nhật danh sách phòng
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
                          ? getHotelColor(button['hotelName'])
                          : Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      button["hotelName"],
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedExploreTabIndex == index
                            ? getHotelColor(button['hotelName'])
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
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: room['listImage'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                GlobalData.api +
                                    room['listImage'][index]['imageURL'],
                                height: 300,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phòng: ${room["roomName"]}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text("Loại phòng: ${room["roomTypeName"]}",
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 5),
                          Text(
                              "Giá qua đêm: ${room["pricePerNight"].toString()} VNĐ",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          Text(
                              "Giá theo giờ: ${room["pricePerHour"].toString()} VNĐ",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              );
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

  // Future<void> DsHotel() async {
  //   final response = await ApiHotel.dsHotel();
  //   for (var element in response) {
  //     setState(() {
  //       navigationButtons.add({
  //         "icon": Icons.hotel,
  //         "label": element.hotelName,
  //         'hotelId': element.hotelId,
  //       });
  //     });
  //   }
  // }

  // Future<void> DsRoom(int hotelId) async {
  //   final response = await ApiRoom.dsRoom(hotelId);
  //   List<Map<String, dynamic>> data = [];
  //   for (var element in response) {
  //     data.add({
  //       "roomId": element.roomId,
  //       "roomName": element.roomName,
  //       "floor": element.floor,
  //       "roomTypeName": element.roomTypeName,
  //       "description": element.description,
  //       "pricePerHour": element.pricePerHour,
  //       "pricePerNight": element.pricePerNight,
  //       "hotelId": element.hotelId,
  //       "listImage": element.listImage
  //     });
  //   }
  //   setState(() {
  //     roomList = data;
  //   });
  // }

  // Future<void> loadData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? jsonData = prefs.getString('userData');
  //   Map<String, dynamic> user = json.decode(jsonData!); // Chuyển lại thành Map
  //   print('Data ${user['firstName']} ${user['lastName']}');
  // }
}
