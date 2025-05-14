import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:android_hms/models/entities/room.dart';
import 'package:android_hms/core/constants/api_constants.dart';

import 'package:android_hms/views/component/skeletons/info_room_skeleton.dart';
import 'package:android_hms/views/component/text_Poppins.dart';

class InfoRoom extends StatelessWidget {
  final Room room;
  final bool isLoading; // Thêm cờ isLoading

  const InfoRoom(
      {super.key,
      required this.room,
      this.isLoading = false}); // Thêm isLoading vào constructor

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const InfoRoomSkeleton(); // Hiển thị skeleton nếu isLoading là true
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300, // Màu viền
          width: 1.0, // Độ dày viền
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    room.roomImages.isNotEmpty ? room.roomImages.length : 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400, // Màu viền
                              width: 1.0, // Độ dày viền
                            ),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: room.roomImages.isNotEmpty
                                  ? NetworkImage(APIConstants.api +
                                      room.roomImages[index]['imageURL'])
                                  : AssetImage('assets/images/noimg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
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
                  TextPoppins(
                    title: "Phòng: ${room.roomName}",
                    size: 18,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(height: 5),
                  TextPoppins(
                    color: Colors.grey[500],
                    title: "Loại phòng: ${room.roomTypeName}",
                    size: 18,
                    weight: FontWeight.w500,
                  ),
                  const SizedBox(height: 5),
                  TextPoppins(
                    color: Color.fromRGBO(34, 34, 34, 1),
                    title:
                        "Giá qua đêm: ${NumberFormat('#,###', 'vi_VN').format(room.pricePerNight)} VNĐ",
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
