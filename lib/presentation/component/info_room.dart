import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/GlobalData.dart';
import 'package:flutter/material.dart';

class InfoRoom extends StatelessWidget {
  final Room room;

  const InfoRoom({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: room.listImage.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      GlobalData.api + room.listImage[index]['imageURL'],
                      height: 300,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
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
                Text(
                  "Phòng: ${room.roomName}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text("Loại phòng: ${room.roomTypeName}",
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                Text("Giá qua đêm: ${room.pricePerNight.toString()} VNĐ",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                Text("Giá theo giờ: ${room.pricePerHour.toString()} VNĐ",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
