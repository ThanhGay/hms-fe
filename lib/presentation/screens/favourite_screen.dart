import 'package:android_hms/Data/favourite_provider.dart';
import 'package:android_hms/Entity/favourite.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/services/api_favourite.dart';
import 'package:android_hms/core/services/api_hotel.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/presentation/component/info_card.dart';
import 'package:android_hms/presentation/component/info_room.dart';
import 'package:android_hms/presentation/screens/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreen();
}

class _FavouriteScreen extends State<FavouriteScreen> {
  List<Room> roomFavourite = [];
  @override
  void initState() {
    super.initState();

    // ApiFavourite.favourite(context).then((data) {
    //   print("Helll word");
    // }).catchError((error) {});
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await ApiFavourite.favourite(context);

    // Lấy danh sách khách sạn từ Provider
    final favProv =
        Provider.of<FavouriteProvider>(context, listen: false).favourite;

    for (var element in favProv) {
      ApiRoom.RoomById(context, element.roomId).then((data) {
        setState(() {
          roomFavourite.add(data);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: roomFavourite.length,
          itemBuilder: (context, index) {
            return TextButton(
                onPressed: () {},
                child:
                    Text(roomFavourite[index].description ?? "Chưa xác định"));
          },
        ),
      ),
    ]);
  }
}
