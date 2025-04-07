import 'package:android_hms/presentation/screens/booking_option_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/Entity/hotel.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:intl/intl.dart';

class BookingReviewScreen extends StatefulWidget {
  final Room roomDetail;
  final Hotel hotel;

  const BookingReviewScreen({
    super.key,
    required this.roomDetail,
    required this.hotel,
  });

  @override
  _BookingReviewScreenState createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  DateTimeRange? selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  int numberOfNights() {
    int nights =
        selectedDateRange!.end.difference(selectedDateRange!.start).inDays;
    return nights == 0 ? 1 : nights;
  }

  Future<void> _openBookingOptions(BuildContext context) async {
    final result = await showModalBottomSheet<DateTimeRange>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return BookingOptionsSheet();
      },
    );

    if (result != null) {
      setState(() {
        selectedDateRange = result; // Cập nhật ngày đã chọn
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice =
        numberOfNights() * (widget.roomDetail.pricePerNight ?? 0).toInt();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                widget.roomDetail.roomImages[0]['imageURL'],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phòng: ${widget.roomDetail.roomName}",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Khách sạn: ${widget.hotel.hotelName}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600]),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 18),
                                  SizedBox(width: 4),
                                  Text(
                                    "4,83 (111)",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey, thickness: 1, height: 1),
                    SizedBox(height: 20),

                    // Thông tin chuyến đi
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
                              "${selectedDateRange!.start.day}/${selectedDateRange!.start.month} - ${selectedDateRange!.end.day}/${selectedDateRange!.end.month}",
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
                          onPressed: () => _openBookingOptions(context),
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
                    Divider(color: Colors.grey, thickness: 1, height: 1),
                    SizedBox(height: 20),

                    // Giá
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
                              "đ ${NumberFormat('#,###', 'vi_VN').format(totalPrice)} VNĐ",
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
                    Divider(color: Colors.grey, thickness: 1, height: 1),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Đặt phòng/đặt chỗ này không được hoàn tiền.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
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
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Quay lại",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
