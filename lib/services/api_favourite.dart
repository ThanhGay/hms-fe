import 'package:android_hms/views/storages/favourite_provider.dart';
import 'package:android_hms/models/entities/favourite.dart';
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/services/dioClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiFavourite {
  static Future<List<Favourite>> favourite(BuildContext context,
      [String keyWord = '']) async {
    Response response;
    final String url = "${APIConstants.api}get-all-favourite?KeyWord=$keyWord";
    List<Favourite> favourites = [];
    try {
      response = await DioClient().dio.get(url);

      List<dynamic> allFavourite = response.data['items'];

      favourites = allFavourite
          .map((favourite) => Favourite.fromJson(favourite))
          .toList();
      Provider.of<FavouriteProvider>(context, listen: false)
          .setFavourite(favourites);
      return favourites;
    } on DioException catch (e) {
      print("${e.response}");
      throw e;
    }
  }

  static Future<void> addFavourite(BuildContext context, int roomId) async {
    final String url = "${APIConstants.api}add-favourite?roomId=$roomId";
    print("add favourite");
    try {
      await DioClient().dio.get(url);
    } on DioException catch (e) {
      print("${e.response}");
    }
  }

  static Future<void> removeFavourite(BuildContext context, int roomId) async {
    final String url = "${APIConstants.api}remove-favourite?roomId=$roomId";
    print("remove favourite");
    try {
      await DioClient().dio.get(url);
    } on DioException catch (e) {
      print("${e.response}");
    }
  }
}
