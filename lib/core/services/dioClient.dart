import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString("token");

        print("Interceptor đang hoạt động! Token: $token");

        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
          options.headers["Accept"] = "application/json";
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("Lỗi API: ${e.message}");
        return handler.next(e);
      },
    ));
  }
}
