import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/core/models/bill/ICreatePreBooking.dart';
import 'package:android_hms/core/services/Bill/api_createPreBill.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/presentation/screens/booking_option_sheet_screen.dart';
import 'package:android_hms/presentation/screens/booking_payment_screen.dart';
import 'package:android_hms/presentation/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingReviewScreen extends StatefulWidget {
  final int roomId;
  final int hotelId;

  const BookingReviewScreen(
      {super.key, required this.roomId, required this.hotelId});

  @override
  _BookingReviewScreenState createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  Room? roomDetail;
  DateTimeRange? selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  int adults = 1;
  int children = 0;
  int babies = 0;
  int pets = 0;

  @override
  void initState() {
    super.initState();
    ApiRoom.getRoomById(widget.roomId).then((data) {
      setState(() {
        roomDetail = data;
      });
    });
  }

  String formatedDateNow =
      DateFormat('EEE, MMMM dd', 'en-US').format(DateTime.now());

  void _openBookingOptions() async {
    // Mở popup và chờ kết quả trả về
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => BookingOptionsSheet(
        initialDateRange: selectedDateRange,
        initialAdults: adults,
        initialChildren: children,
        initialBabies: babies,
        initialPets: pets,
      ),
    );

    // Cập nhật trạng thái nếu có dữ liệu trả về
    if (result != null) {
      setState(() {
        selectedDateRange = result['selectedDateRange'];
        adults = result['adults'];
        children = result['children'];
        babies = result['babies'];
        pets = result['pets'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // int totalPrice =
    //     numberOfNights() * (widget.roomDetail.pricePerNight ?? 0).toInt();
    var totalPrice = (roomDetail != null && selectedDateRange != null)
    ? formatNumber(roomDetail!.pricePerNight * selectedDateRange!.duration.inDays)
    : "0";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Kiểm tra lại và tiếp tục",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: roomDetail == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card for trip details
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  APIConstants.api +
                                      roomDetail!.roomImages[0]['imageURL'],
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.image_not_supported,
                                        size: 80, color: Colors.grey);
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      roomDetail!.roomName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Rating
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.orange, size: 18),
                                          SizedBox(width: 4),
                                          Text(
                                            "4,83 (111)",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 1,
                          ),
                          SizedBox(height: 20),

                          // Trip info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Thông tin chuyến đi",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    formatedDateNow,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    "1 người lớn",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  _openBookingOptions();
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "Thay đổi",
                                  style: TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 1,
                          ),
                          SizedBox(height: 20),

                          // Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tổng giá",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "$totalPrice VNĐ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "Chi tiết",
                                  style: TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 1,
                          ),
                          SizedBox(height: 20),

                          // Price note
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Đặt phòng/đặt chỗ này không được hoàn tiền.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    "Thay đổi chính sách",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  // Bottom buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Quay lại",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // Navigator.pushNamed(context, '/payment');
                          final result = await ApiBill.createPreBil(
                              ICreatePreBooking(
                                  BookingDate: DateTime.now(),
                                  ExpectedCheckIn: selectedDateRange!.start,
                                  ExpectedCheckOut: selectedDateRange!.end,
                                  DiscountID: null,
                                  CustomerID: 24,
                                  RoomIds: [roomDetail!.roomId]));
                          if (result == "Thêm thành công") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingPaymentScreen(
                                  roomId: widget.roomId, // Truyền `roomDetail` đã có dữ liệu
                                  hotelId: widget.hotelId, 
                                  totalPrice: totalPrice,
                                ),
                              ),
                            );
                            // Navigator.pushNamed(context, '/payment',
                            // arguments: {
                            //     'totalPrice': totalPrice,
                            //   },
                            // );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Đặt phòng thành công')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result)),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Tiếp theo",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
