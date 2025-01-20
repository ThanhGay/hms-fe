import 'package:flutter/material.dart';

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
    Center(child: Text('Trang Yêu Thích', style: TextStyle(fontSize: 20))),
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
  final List<List<Map<String, dynamic>>> exploreTabData = [
    [
      {
        "imageAssetPath": "assets/images/phong_khach.png",
        "location": "Uccle, Bỉ",
        "host": "Chủ nhà: Marianne · Đã nghỉ hưu",
        "price": "941.170 / đêm",
        "rating": 4.89,
      },
      {
        "imageAssetPath": "assets/images/phong_ngu.png",
        "location": "Brussels, Bỉ",
        "host": "Chủ nhà: Jean · Chào mừng",
        "price": "1.200.000 / đêm",
        "rating": 4.95,
      },
      {
        "imageAssetPath": "assets/images/ban_cong.png",
        "location": "Ghent, Bỉ",
        "host": "Chủ nhà: Laura · Thân thiện",
        "price": "850.000 / đêm",
        "rating": 4.75,
      },
    ],
    [
      {
        "imageAssetPath": "assets/images/phong_ngu.png",
        "location": "Hà Nội, Việt Nam",
        "host": "Chủ nhà: Đăng Khoa · Đã nghỉ hưu",
        "price": "1.111.170 / đêm",
        "rating": 5.0,
      },
      {
        "imageAssetPath": "assets/images/phong_khach.png",
        "location": "Brussels, Bỉ",
        "host": "Chủ nhà: Jean · Chào mừng",
        "price": "1.200.000 / đêm",
        "rating": 4.95,
      },
      {
        "imageAssetPath": "assets/images/ban_cong.png",
        "location": "Ghent, Bỉ",
        "host": "Chủ nhà: Laura · Thân thiện",
        "price": "850.000 / đêm",
        "rating": 4.75,
      },
    ],
    [
      {
        "imageAssetPath": "assets/images/nong_thon_1.png",
        "location": "Hà Nội, Việt Nam",
        "host": "Chủ nhà: Đăng Khoa · Đã nghỉ hưu",
        "price": "1.111.170 / đêm",
        "rating": 5.0,
      },
      {
        "imageAssetPath": "assets/images/nong_thon_2.png",
        "location": "Brussels, Bỉ",
        "host": "Chủ nhà: Jean · Chào mừng",
        "price": "1.200.000 / đêm",
        "rating": 4.95,
      },
      {
        "imageAssetPath": "assets/images/ban_cong.png",
        "location": "Ghent, Bỉ",
        "host": "Chủ nhà: Laura · Thân thiện",
        "price": "850.000 / đêm",
        "rating": 4.75,
      },
    ],
    [
      {
        "imageAssetPath": "assets/images/khung_canh_1.png",
        "location": "Hà Nội, Việt Nam",
        "host": "Chủ nhà: Đăng Khoa · Đã nghỉ hưu",
        "price": "1.111.170 / đêm",
        "rating": 5.0,
      },
      {
        "imageAssetPath": "assets/images/khung_canh_2.png",
        "location": "Brussels, Bỉ",
        "host": "Chủ nhà: Jean · Chào mừng",
        "price": "1.200.000 / đêm",
        "rating": 4.95,
      },
      {
        "imageAssetPath": "assets/images/ban_cong.png",
        "location": "Ghent, Bỉ",
        "host": "Chủ nhà: Laura · Thân thiện",
        "price": "850.000 / đêm",
        "rating": 4.75,
      },
    ],
    [
      {
        "imageAssetPath": "assets/images/nha_cay_1.png",
        "location": "Hà Nội, Việt Nam",
        "host": "Chủ nhà: Đăng Khoa · Đã nghỉ hưu",
        "price": "1.111.170 / đêm",
        "rating": 5.0,
      },
      {
        "imageAssetPath": "assets/images/nong_thon_3.png",
        "location": "Brussels, Bỉ",
        "host": "Chủ nhà: Jean · Chào mừng",
        "price": "1.200.000 / đêm",
        "rating": 4.95,
      },
      {
        "imageAssetPath": "assets/images/khung_canh_3.png",
        "location": "Ghent, Bỉ",
        "host": "Chủ nhà: Laura · Thân thiện",
        "price": "850.000 / đêm",
        "rating": 4.75,
      },
    ],
  ];

  // Dữ liệu mẫu cho danh sách phòng hiện tại
  List<Map<String, dynamic>> roomList = [];

  // Danh sách nút điều hướng
  final List<Map<String, dynamic>> navigationButtons = [
    {"icon": Icons.hotel, "label": "Phòng"},
    {"icon": Icons.star, "label": "Biểu tượng"},
    {"icon": Icons.park, "label": "Nông thôn"},
    {"icon": Icons.landscape, "label": "Khung cảnh tuyệt vời"},
    {"icon": Icons.home, "label": "Nhà nghỉ"},
  ];

  @override
  void initState() {
    super.initState();
    // Khởi tạo roomList với dữ liệu của tab đầu tiên
    roomList = exploreTabData[0];
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
                onTap: () {
                  setState(() {
                    selectedExploreTabIndex = index;
                    roomList = exploreTabData[index]; // Cập nhật danh sách phòng
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      button["icon"],
                      color: selectedExploreTabIndex == index ? Colors.red : Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      button["label"],
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedExploreTabIndex == index ? Colors.red : Colors.black,
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
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        room["imageAssetPath"],
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room["location"],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(room["host"], style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 5),
                          Text("₫${room["price"]}", style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 5),
                              Text(room["rating"].toString(), style: const TextStyle(fontSize: 14)),
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
}
