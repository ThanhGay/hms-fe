
import 'package:android_hms/core/constants/api_constants.dart';
import 'package:android_hms/services/dioClient.dart';
import 'package:dio/dio.dart';

class ApiCreateVote {
  static Future<String?> createVote(int roomId, int star, String comment) async {
    const String url = "${APIConstants.api}api/room/vote/create";

    try {
      final response = await DioClient().dio.post(
        url,
        data: {
          "roomId": roomId,
          "star": star,
          "comment": comment,
        },
      );
            if (response.statusCode == 200) {
        if (response.data is String) {
          return response.data; 
        } else {
          
          return "Đánh giá thất bại: Không xác định dữ liệu trả về.";
        }
      } else {
        return "Đánh giá thất bại: ${response.data['message']}";
      }

  
    } on DioException catch (e) {
      return "Lỗi kết nối API: ${e.message}";
    }
  }
}
