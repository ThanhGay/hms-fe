import 'package:flutter/material.dart';

class RoomDetailScreen extends StatelessWidget {
  final int roomId;
  final int hotelId;

  const RoomDetailScreen({super.key, required this.roomId,required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero, 
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/khung_canh_3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Huntsman's Harbour",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Toàn bộ cabin tại Lancashire, Vương quốc Anh",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Text("2 khách • 1 phòng ngủ • 1 giường • 1 phòng tắm",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600])),

                      SizedBox(height: 10),

                      
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          SizedBox(width: 5),
                          Text("4.94",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Text("67 đánh giá",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue[700])),
                        ],
                      ),

                      Divider(height: 30),

                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/images/khung_canh_2.png'),
                            radius: 25,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Khách sạn: 4 chúng mình",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("Khách sạn siêu cấp",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700])),
                              Text("2 năm kinh nghiệm đón tiếp khách",
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Vị trí
                      Row(
                        children: [
                          Icon(Icons.directions_walk, size: 18),
                          SizedBox(width: 5),
                          Text("Cách hồ 1 phút đi bộ",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),

                      SizedBox(height: 100),

                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.grey.shade300)),
              color: Colors.white, 
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Giá tiền bên trái
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "₫7.049.159 / đêm",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("21 - 26 tháng 2",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),

                SizedBox(width: 30),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF385C), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Đặt phòng",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
