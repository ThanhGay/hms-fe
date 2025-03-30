import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/presentation/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoRoom extends StatelessWidget {
  final Room room;

  const InfoRoom({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: room.roomImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      APIConstants.api + room.roomImages[index]['imageURL'],
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
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 20.02 / 14,
                    color: Color.fromRGBO(34, 34, 34, 1),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Loại phòng: ${room.roomTypeName}",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 20.02 / 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Giá qua đêm: ${formatNumber(room.pricePerNight)} VNĐ",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 20.02 / 14,
                    color: Color.fromRGBO(34, 34, 34, 1),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Giá theo giờ: ${formatNumber(room.pricePerHour)} VNĐ",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 20.02 / 14,
                    color: Color.fromRGBO(34, 34, 34, 1),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
