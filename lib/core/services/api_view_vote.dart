import 'dart:convert';
import 'package:android_hms/core/models/votes/vote_model.dart';
import 'package:http/http.dart' as http;
import 'package:android_hms/core/constants/api_constants.dart';


class ApiViewVote {
  static Future<VoteData?> viewVote(int roomId) async {
    final String url = "${APIConstants.api}api/room/vote/view/$roomId";
    final uri = Uri.parse(url);

    try {
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return VoteData.fromJson(data);
      } else {
        print("Lỗi lấy đánh giá: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Lỗi kết nối đánh giá: $e");
      return null;
    }
  }
}
