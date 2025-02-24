import 'package:android_hms/core/services/api_favourite.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreen();
}

class _FavouriteScreen extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    ApiFavourite.favourite(context).then((data) {}).catchError((error) {});
  }

  List<String> favoriteItems = ["Sách", "Nhạc", "Phim"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách yêu thích"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(favoriteItems[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => (),
              ),
            ),
          );
        },
      ),
    );
  }
}
