import 'package:android_hms/presentation/screens/booking_option_sheet_screen.dart';
import 'package:flutter/material.dart';

class BookingReviewScreen extends StatelessWidget {
  final int roomId;
  final int hotelId;
  const BookingReviewScreen({super.key, required this.roomId, required this.hotelId});
  @override
  Widget build(BuildContext context) {
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
                          borderRadius:
                              BorderRadius.circular(10), 
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 80, 
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cabin không gian sâu Trên\nmột bãi biển yên tĩnh",
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
                              "Thứ 6, 12 Tháng 11",
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
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              builder: (context) {
                                return Scaffold(
                                  body:
                                      BookingOptionsSheet(),
                                );
                              },
                            );
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
                              "đ 10.567.215 VND",
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
                    // Price
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment');
                  },
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
