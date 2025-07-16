import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.deezer.com/",
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    
    ),
  );

  factory DioClient() => _instance;

  DioClient._internal() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // final token =
      }
    ));
  }
}

