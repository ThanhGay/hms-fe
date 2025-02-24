import 'package:android_hms/Data/favourite_provider.dart';
import 'package:android_hms/Entity/favourite.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/core/services/dioClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiFavourite {
  static Future<void> favourite(BuildContext context) async {
    Response response;
    const String url = "${APIConstants.api}get-all-favourite";
    List<Favourite> favourites = [];
    try {
      response = await DioClient().dio.get(url);

      List<dynamic> allFavourite = response.data['items'];

      favourites = allFavourite
          .map((favourite) => Favourite.fromJson(favourite))
          .toList();

      Provider.of<FavouriteProvider>(context, listen: false)
          .setFavourite(favourites);
    } on DioException catch (e) {
      print("${e.response}");
    }
  }
}
