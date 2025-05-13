import 'package:android_hms/Data/favourite_provider.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/core/models/votes/vote_model.dart';
import 'package:android_hms/core/services/api_favourite.dart';
import 'package:android_hms/core/services/api_hotel.dart';
import 'package:android_hms/core/services/api_view_vote.dart';
import 'package:android_hms/presentation/screens/booking_review_screen.dart';
import 'package:android_hms/presentation/screens/vote_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  VoteData? voteData;
  bool isFavorite = false;
  bool showAllReviews = false;
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
    ApiViewVote.viewVote(widget.roomId).then((data) {
      if (data != null) {
        setState(() {
          voteData = data;
        });
      }
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
                            borderRadius: BorderRadius.circular(2),
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
                                Text(
                                  voteData != null
                                      ? voteData!.value.toStringAsFixed(1)
                                      : "Chưa có",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  voteData != null
                                      ? "${voteData!.total} đánh giá"
                                      : "Đang tải...",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue[700]),
                                ),
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
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: TextButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VoteRoomScreen(
                                                        roomId: widget.roomId),
                                              ),
                                            );
                                            // Gọi lại API sau khi người dùng đánh giá xong
                                            final updatedVoteData =
                                                await ApiViewVote.viewVote(
                                                    widget.roomId);
                                            if (updatedVoteData != null) {
                                              setState(() {
                                                voteData = updatedVoteData;
                                              });
                                            }
                                          },
                                          child: Text('Đánh giá ngay',
                                              style: TextStyle(
                                                  color: Colors.blue[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ),
                                      ),

                                      Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              voteData != null
                                                  ? voteData!.value
                                                      .toStringAsFixed(1)
                                                  : "0.0",
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              voteData != null &&
                                                      voteData!.total > 0
                                                  ? "Được khách yêu thích"
                                                  : "Chưa có đánh giá",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              voteData != null
                                                  ? "${voteData!.total} đánh giá"
                                                  : "",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // Danh sách bình luận
                                      if (voteData != null &&
                                          voteData!.detailReviews.isNotEmpty)
                                        ...(showAllReviews
                                                ? voteData!.detailReviews
                                                : voteData!.detailReviews
                                                    .take(2))
                                            .map((review) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 4,
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Sao và thời gian
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children:
                                                                  List.generate(
                                                                review.star,
                                                                (index) => const Icon(
                                                                    Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .orange),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              DateFormat(
                                                                      'dd/MM/yyyy - HH:mm')
                                                                  .format(review
                                                                      .create),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 6),
                                                        // Nội dung bình luận
                                                        Text(
                                                          review.commemt,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                      // Nút xem thêm / ẩn bớt

                                      if (voteData != null &&
                                          voteData!.detailReviews.length >= 3)
                                        Center(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                showAllReviews =
                                                    !showAllReviews;
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Text(
                                                  showAllReviews
                                                      ? 'Ẩn bớt bình luận'
                                                      : 'Hiển thị tất cả bình luận',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                                Icon(
                                                  showAllReviews
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                          .keyboard_arrow_down,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                                  roomId: widget
                                      .roomId, // Truyền `roomDetail` đã có dữ liệu
                                  hotelId: widget.roomId,
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
