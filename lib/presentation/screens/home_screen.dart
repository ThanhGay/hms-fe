import 'dart:convert';

import 'package:android_hms/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomTabIndex = 0; // Chỉ số của Bottom Navigation Bar

  // Nội dung chính cho từng trang chính của Bottom Navigation Bar
  final List<Widget> mainPages = [
    const ExplorePage(), // Trang Khám Phá
    Center(child: Text('Trang Thích', style: TextStyle(fontSize: 20))),
    Center(child: Text('Trang Chuyến Đi', style: TextStyle(fontSize: 20))),
    Center(child: Text('Trang Tin Nhắn', style: TextStyle(fontSize: 20))),
    Center(child: Text('Trang Đăng Nhập', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
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

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int selectedExploreTabIndex = 0;

  // Dữ liệu mẫu cho các danh sách phòng dựa trên từng nút điều hướng
  // List<List<Map<String, dynamic>>> exploreTabData = [
  //   [
  //     {
  //       "imageAssetPath": "assets/images/phong_khach.png",
  //       "roomName": "Uccle, Bỉ",
  //       "host": "Chủ nhà: Marianne · Đã nghỉ hưu",
  //       "price": "941.170 / đêm",
  //       "rating": 4.89,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/phong_ngu.png",
  //       "roomName": "Brussels, Bỉ",
  //       "host": "Chủ nhà: Jean · Chào mừng",
  //       "price": "1.200.000 / đêm",
  //       "rating": 4.95,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/ban_cong.png",
  //       "roomName": "Ghent, Bỉ",
  //       "host": "Chủ nhà: Laura · Thân thiện",
  //       "price": "850.000 / đêm",
  //       "rating": 4.75,
  //     },
  //   ],
  //   [
  //     {
  //       "imageAssetPath": "assets/images/phong_ngu.png",
  //       "roomName": "Hà Nội, Việt Nam",
  //       "host": "Chủ nhà: Đăng Khoa · Đã nghỉ hưu",
  //       "price": "1.111.170 / đêm",
  //       "rating": 5.0,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/phong_khach.png",
  //       "roomName": "Brussels, Bỉ",
  //       "host": "Chủ nhà: Jean · Chào mừng",
  //       "price": "1.200.000 / đêm",
  //       "rating": 4.95,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/ban_cong.png",
  //       "roomName": "Ghent, Bỉ",
  //       "host": "Chủ nhà: Laura · Thân thiện",
  //       "price": "850.000 / đêm",
  //       "rating": 4.75,
  //     },
  //   ],
  //   [
  //     {
  //       "imageAssetPath": "assets/images/nong_thon_1.png",
  //       "roomName": "Hà Nội, Việt Nam",
  //       "host": "Chủ nhà: Đăng Khoa · Đã nghỉ hưu",
  //       "price": "1.111.170 / đêm",
  //       "rating": 5.0,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/nong_thon_2.png",
  //       "roomName": "Brussels, Bỉ",
  //       "host": "Chủ nhà: Jean · Chào mừng",
  //       "price": "1.200.000 / đêm",
  //       "rating": 4.95,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/ban_cong.png",
  //       "roomName": "Ghent, Bỉ",
  //       "host": "Chủ nhà: Laura · Thân thiện",
  //       "price": "850.000 / đêm",
  //       "rating": 4.75,
  //     },
  //   ],
  //   [
  //     {
  //       "imageAssetPath": "assets/images/khung_canh_1.png",
  //       "roomName": "Hà Nội, Việt Nam",
  //       "host": "Chủ nhà: Đăng Khoa · Đã nghỉ hưu",
  //       "price": "1.111.170 / đêm",
  //       "rating": 5.0,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/khung_canh_2.png",
  //       "roomName": "Brussels, Bỉ",
  //       "host": "Chủ nhà: Jean · Chào mừng",
  //       "price": "1.200.000 / đêm",
  //       "rating": 4.95,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/ban_cong.png",
  //       "roomName": "Ghent, Bỉ",
  //       "host": "Chủ nhà: Laura · Thân thiện",
  //       "price": "850.000 / đêm",
  //       "rating": 4.75,
  //     },
  //   ],
  //   [
  //     {
  //       "imageAssetPath": "assets/images/nha_cay_1.png",
  //       "roomName": "Hà Nội, Việt Nam",
  //       "host": "Chủ nhà: Đăng Khoa · Đã nghỉ hưu",
  //       "price": "1.111.170 / đêm",
  //       "rating": 5.0,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/nong_thon_3.png",
  //       "roomName": "Brussels, Bỉ",
  //       "host": "Chủ nhà: Jean · Chào mừng",
  //       "price": "1.200.000 / đêm",
  //       "rating": 4.95,
  //     },
  //     {
  //       "imageAssetPath": "assets/images/khung_canh_3.png",
  //       "roomName": "Ghent, Bỉ",
  //       "host": "Chủ nhà: Laura · Thân thiện",
  //       "price": "850.000 / đêm",
  //       "rating": 4.75,
  //     },
  //   ],
  // ];

  // Dữ liệu mẫu cho danh sách phòng hiện tại
  List<Map<String, dynamic>> roomList = [];

  // Danh sách nút điều hướng
  final List<Map<String, dynamic>> navigationButtons = [];

  @override
  void initState() {
    super.initState();
    // Khởi tạo roomList với dữ liệu của tab đầu tiên
    DsHotel().then((data) {
      int hotelId = navigationButtons[0]['hotelId'];
      DsRoom(hotelId).then((data) {}).catchError((error) {});
    }).catchError((error) {
      print("Lỗi");
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
                  setState(() {
                    selectedExploreTabIndex = index;
                    // roomList =
                    //     exploreTabData[index]; // Cập nhật danh sách phòng
                  });
                  int hotelId = button['hotelId'];
                  await DsRoom(hotelId);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      button["icon"],
                      color: selectedExploreTabIndex == index
                          ? Colors.red
                          : Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      button["label"],
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedExploreTabIndex == index
                            ? Colors.red
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
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(10),
                    //   child: Image.asset(
                    //     room["imageAssetPath"],
                    //     height: 300,
                    //     width: double.infinity,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: room['roomImages'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                GlobalData.api +
                                    room['roomImages'][index]['imageURL'],
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
                            room["roomName"],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(room["roomName"],
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 5),
                          Text("₫${room["roomName"]}",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 5),
                              Text(room["roomName"].toString(),
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
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

  Future<void> DsHotel() async {
    const String url = "${GlobalData.api}api/hotel/all";
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          for (var element in data['items']) {
            navigationButtons.add({
              "icon": Icons.hotel,
              "label": element['hotelName'],
              'hotelId': element['hotelId']
            });
          }
        });
      } else {
        print("Lỗi API: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
  }

  Future<void> DsRoom(int hotelId) async {
    final String url = "${GlobalData.api}api/room/all?hotelId=${hotelId}";
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        List<Map<String, dynamic>> listRoom =
            List<Map<String, dynamic>>.from(data['items']);
        setState(() {
          roomList = listRoom;
          print(listRoom[0]['roomImages']);
        });
      } else {
        print("Lỗi API: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
  }
}
