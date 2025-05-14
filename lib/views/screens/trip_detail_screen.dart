import 'package:flutter/material.dart';
import 'package:android_hms/models/entities/mybill.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/core/constants/default.dart';
import 'package:android_hms/services/Bill/api_get_booking.dart';
import 'package:android_hms/services/Bill/api_cancelBill.dart';
import 'package:android_hms/views/screens/vote_room_screen.dart';
import 'package:android_hms/core/utils/toast.dart';
import 'package:android_hms/core/utils/util.dart';

(Color, Color) styleFromStatus(String status) {
  switch (status) {
    case "PreBooking":
      return (Colors.limeAccent, Colors.black);
    case "Waiting payment":
      return (Colors.red, Colors.white);
    case "Stay":
      return (Colors.green, Colors.white);
    default:
      return (Colors.red, Colors.white);
  }
}

class TripDetailScreen extends StatefulWidget {
  final int billId;
  const TripDetailScreen({super.key, required this.billId});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin chuyến đi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<MyBill>(
          future: ApiBill.detailBill(widget.billId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final MyBill bill = snapshot.data!;
              return _showDetailBill(context, bill);
            } else {
              return const Center(child: Text('Không có dữ liệu'));
            }
          },
        ),
      ),
    );
  }

  Widget _showDetailBill(BuildContext context, MyBill bill) {
    final roomDetail = bill.rooms[0];
    final diff = bill.expectedCheckOut.difference(bill.expectedCheckIn).inDays;
    final (bgColor, txtColor) = styleFromStatus(bill.status);

    Future<void> onCancel() async {
      bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Cảnh báo"),
              content: Text(
                  "Bạn chắc chắn muốn hủy đặt phòng? Lưu ý sẽ không được hoàn lại tiền !!!"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Hủy"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("Xác nhận"),
                ),
              ],
            ),
          ) ??
          false;

      if (confirm) {
        final statusCode = await ApiCancelBill.cancelBill(bill.billID);
        // final statusCode = "Success";

        if (statusCode == "Success") {
          showToast(
              msg: ("Hủy đặt phòng thành công!"),
              backgroundColor: Colors.green[400],
              textColor: Colors.white);

          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushNamed(
              context,
              '/home',
              arguments: {"initialTabIndex": 0},
            );
          });
        } else {
          showToast(
              msg: ("Đã có lỗi khi hủy đặt phòng"),
              backgroundColor: Colors.orange[400],
              textColor: Colors.white);
        }
      }
    }

    return SingleChildScrollView(
      child: Column(
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
                        "Từ:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        bill.checkIn != null
                            ? formatDateTime(bill.checkIn!, 'dd/MM/yyyy hh:MM')
                            : formatDateTime(
                                bill.expectedCheckIn, 'dd/MM/yyyy hh:MM'),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Đến:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        bill.checkOut != null
                            ? formatDateTime(bill.checkOut!, 'dd/MM/yyyy hh:MM')
                            : formatDateTime(
                                bill.expectedCheckOut, 'dd/MM/yyyy hh:MM'),
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
                      Text(
                          '${bill.status == "Waiting payment" ? "0" : formatCurrency(bill.prepayment ?? 0)} VNĐ'),
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
                    color: bgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    bill.status,
                    style: TextStyle(
                      color: txtColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 36),
          // if (bill.status == 'PreBooking' || bill.status == 'Waiting payment')
          //   Center(
          //     child: SizedBox(
          //       width: double.infinity,
          //       child: OutlinedButton(
          //         onPressed: onCancel,
          //         style: OutlinedButton.styleFrom(
          //           side: const BorderSide(color: Colors.black),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //         ),
          //         child: Text(
          //           'Huỷ đặt phòng',
          //           style: TextStyle(color: Colors.black, fontSize: 16),
          //         ),
          //       ),
          //     ),
          //   ),
          Center(
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VoteRoomScreen(roomId: bill.rooms[0].roomID),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      child: Text('Đánh giá ngay',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)))))
        ],
      ),
    );
  }
}
