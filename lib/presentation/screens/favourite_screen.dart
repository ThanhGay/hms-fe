import 'package:android_hms/Data/favourite_provider.dart';
import 'package:android_hms/Entity/favourite.dart';
import 'package:android_hms/Entity/room.dart';
import 'package:android_hms/core/services/api_favourite.dart';
import 'package:android_hms/core/services/api_hotel.dart';
import 'package:android_hms/core/services/api_room.dart';
import 'package:android_hms/presentation/component/info_card.dart';
import 'package:android_hms/core/services/api_room.dart';
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
  List<Room> rooms = [];
  List<Favourite> favoriteItems = [];
  @override
  void initState() {
    super.initState();
    ApiFavourite.favourite(context).then((data) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final proFavourite = Provider.of<FavouriteProvider>(context);
    setState(() {
      favoriteItems = proFavourite.favourite;
      if (favoriteItems.isNotEmpty) {
        List<Room> roomFav = [];
        for (var element in favoriteItems) {
          ApiRoom.getRoomById(context, element.roomId).then((data) {
            roomFav.add(data);
            setState(() {
              rooms = roomFav;
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách yêu thích"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                if (rooms.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomDetailScreen(
                        roomId: rooms[index].roomId,
                        hotelId: rooms[index].hotelId,
                      ),
                    ),
                  );
                } else {
                  debugPrint("Error: No hotel data available!");
                }
              },
              child: InfoRoom(room: rooms[index]));
        },
      ),
    );
  }
}
