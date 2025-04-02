import 'package:android_hms/Data/favourite_provider.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/core/services/api_favourite.dart';
import 'package:android_hms/core/services/api_hotel.dart';
import 'package:android_hms/presentation/screens/booking_option_sheet_screen.dart';
import 'package:android_hms/presentation/screens/booking_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:android_hms/presentation/utils/util.dart';
import 'package:android_hms/core/constants/default.dart';
import 'package:android_hms/core/constants/api_constants.dart';

import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/Entity/room.dart';

class RoomDetailScreen extends StatefulWidget {
  final int roomId;
  final int hotelId;

  const RoomDetailScreen(
      {super.key, required this.roomId, required this.hotelId});

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  Room? roomDetail;
  Hotel? hotel;
  bool isFavorite = false;
  DateTimeRange? selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchRoomDetail();
    ApiHotel.getHotelById(context, widget.hotelId).then((data) {
      setState(() {
        hotel = data;
      });
    });
  }


  Future<void> _fetchRoomDetail() async {
    try {
      await ApiRoom.dsRoom(context, widget.hotelId);
      final roomProvider = Provider.of<RoomProvider>(context, listen: false);
      final favourite = Provider.of<FavouriteProvider>(context, listen: false);
      setState(() {
        roomDetail = roomProvider.room
            .firstWhere((room) => room.roomId == widget.roomId);
        bool isFav =
            favourite.favourite.any((fav) => fav.roomId == roomDetail?.roomId);
        print("isFav: ${isFav}");
        isFavorite = isFav;
      });
    } catch (error) {
      print("Error fetching room details: $error");
    }
  }

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
              icon: Icon(Icons.share, color: Colors.black), onPressed: () {}),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border, // Đổi icon
              color: isFavorite ? Colors.red : Colors.black, // Đổi màu
            ),
            onPressed: () async {
              await (isFavorite
                  ? ApiFavourite.removeFavourite
                  : ApiFavourite.addFavourite)(context, widget.roomId);
              setState(() {
                isFavorite = !isFavorite; // Đảo trạng thái khi bấm nút
              });
            },
          )
        ],
      ),
      body: roomDetail == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Hiển thị loading nếu dữ liệu chưa có
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // Hình ảnh phòng (Nếu có)
                      if (roomDetail!.roomImages.isNotEmpty)
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(APIConstants.api +
                                  roomDetail!.roomImages[0]['imageURL']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                  DefaultConstants().defaultImageRoom),
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
                              "Phòng: ${roomDetail!.roomName}",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              roomDetail!.description,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Loại phòng: ${roomDetail!.roomTypeName}",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.orange, size: 20),
                                SizedBox(width: 5),
                                Text("4.94",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 10),
                                Text("67 đánh giá",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blue[700])),
                              ],
                            ),
                            Divider(height: 30),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      DefaultConstants().defaultImageHotel),
                                  radius: 25,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Khách sạn: ${hotel?.hotelName}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Khách sạn siêu cấp",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700])),
                                    Text("2 năm kinh nghiệm đón tiếp khách",
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.directions_walk, size: 18),
                                SizedBox(width: 5),
                                Text("Vị trí: ${hotel?.hotelAddress}",
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

                // Thanh đặt phòng
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey.shade300)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${formatNumber(roomDetail!.pricePerNight)} VNĐ / đêm",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          //    Text(
                          //   "₫${formatNumber(roomDetail!.pricePerHour)} / giờ",
                          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                          // ),
                          Text(
                            "${selectedDateRange!.start.day}/${selectedDateRange!.start.month} - ${selectedDateRange!.end.day}/${selectedDateRange!.end.month}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
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
                          onPressed: () {
                            print("roomId: ${widget.roomId}");
                            print("hotelId: ${widget.hotelId}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingReviewScreen(
                                  roomId:
                                      widget.roomId, // Truyền `roomDetail` đã có dữ liệu
                                  hotelId: widget.hotelId,
                                ),
                              ),
                            );
                          },
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
