import 'package:android_hms/Entity/mybill.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/core/constants/default.dart';
import 'package:android_hms/core/services/Bill/api_get_booking.dart';
import 'package:android_hms/presentation/utils/util.dart';
import 'package:flutter/material.dart';

class TripDetailScreen extends StatelessWidget {
  final int billId;
  const TripDetailScreen({super.key, required this.billId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin chuyến đi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<MyBill>(
          future: ApiBill.detailBill(billId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final MyBill bill = snapshot.data!;
              return _showDetailBill(bill);
            } else {
              return const Center(child: Text('Không có dữ liệu'));
            }
          },
        ),
      ),
    );
  }

  Widget _showDetailBill(MyBill bill) {
    final roomDetail = bill.rooms[0];
    final diff = bill.expectedCheckOut.difference(bill.expectedCheckIn).inDays;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // slider box
        SizedBox(
          height: 300,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bill.rooms[0].roomImages?.length ?? 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400, // Màu viền
                        width: 1.0, // Độ dày viền
                      ),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: bill.rooms[0].roomImages!.isNotEmpty
                            ? NetworkImage(APIConstants.api +
                                bill.rooms[0].roomImages![index]['imageURL'])
                            : AssetImage('assets/images/noimg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        Text(
          "Phòng: ${roomDetail.roomName}",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          roomDetail.roomTypeDescription!,
          style: TextStyle(
              fontSize: 16, color: const Color.fromARGB(255, 83, 73, 73)),
        ),
        SizedBox(height: 8),
        Text(
          "Loại phòng: ${roomDetail.roomTypeName}",
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.star, color: Colors.orange, size: 20),
            SizedBox(width: 5),
            Text(
              roomDetail.voteData != null
                  ? roomDetail.voteData!.value.toStringAsFixed(1)
                  : "Chưa có",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Text(
              roomDetail.voteData != null
                  ? "${roomDetail.voteData!.total} đánh giá"
                  : "Đang tải...",
              style: TextStyle(fontSize: 14, color: Colors.blue[700]),
            ),
          ],
        ),
        Divider(height: 30),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(DefaultConstants.defaultImageHotel),
              radius: 25,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Khách sạn: ${roomDetail.hotelData?.hotelName}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("Khách sạn siêu cấp",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700])),
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
            Text("Vị trí: ${roomDetail.hotelData?.hotelAddress}",
                style: TextStyle(fontSize: 14)),
          ],
        ),
        Divider(height: 30),

        Stack(
          children: [
            Column(
              children: [
                Row(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Thời gian:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Text(formatDateTime(
                            bill.expectedCheckIn, 'dd/MM/yyyy hh:MM')),
                        Icon(Icons.arrow_right_alt),
                        Text(formatDateTime(
                            bill.expectedCheckOut, 'dd/MM/yyyy hh:MM')),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tổng giá:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${formatCurrency((bill.rooms[0].pricePerNight)! * diff)} VNĐ'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Đã trả:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${formatCurrency(bill.prepayment!)} VNĐ'),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  bill.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
