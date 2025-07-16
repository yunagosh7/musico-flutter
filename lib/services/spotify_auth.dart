import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpotifyDioClient {
  static final SpotifyDioClient _instance = SpotifyDioClient._internal();
  late Dio _dio;
  late Dio _authDio; // Cliente separado para autenticación

  static final String? _clientId = dotenv.env['CLIENT_ID'];
  static final String? _clientSecret = dotenv.env['CLIENT_SECRET'];

  static const String _tokenKey = 'spotify_access_token';
  static const String _tokenExpiryKey = 'spotify_token_expiry';

  factory SpotifyDioClient() => _instance;

  SpotifyDioClient._internal() {
    _initializeDio();
  }

  void _initializeDio() async {
    _dio = Dio(
      BaseOptions(
        baseUrl:
            dotenv.env["SPOTIFY_API_BASE_URL"] ?? "https://api.spotify.com/v1",
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _authDio = Dio(
      BaseOptions(
        baseUrl: "https://accounts.spotify.com/api/",
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getValidToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final newToken = await _refreshToken();
            if (newToken != null) {
              final requestOptions = error.requestOptions;
              requestOptions.headers['Authorization'] = 'Bearer $newToken';

              try {
                final response = await _dio.fetch(requestOptions);
                handler.resolve(response);
                return;
              } catch (er) {
                // Si aún falla, pasar el error original
              }
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<String?> _getValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final expiryTime = prefs.getInt(_tokenExpiryKey);

    if (token == null || expiryTime == null) {
      return await _refreshToken();
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final expiryWithBuffer = (expiryTime - 30000);

    if (now >= expiryWithBuffer) {
      return await _refreshToken();
    }
    return token;
  }

  Future<String?> _refreshToken() async {
    try {
      final credentials = base64Encode(
        utf8.encode('$_clientId:$_clientSecret'),
      );

      final response = await _authDio.post(
        'token',
        data: 'grant_type=client_credentials',
        options: Options(
          headers: {
            'Authorization': 'Basic $credentials',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;

        final accessToken = data['access_token'] as String;
        final expiresIn = data['expires_in'] as int;

        await _saveToken(accessToken, expiresIn);
        return accessToken;
      }
    } catch (er) {
      print('Error while refreshing token: $er ');
    }
  }

  Future<void> _saveToken(String accessToken, int expiresIn) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTime =
        DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000);

    await prefs.setString(_tokenKey, accessToken);
    await prefs.setInt(_tokenExpiryKey, expiryTime);
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }
}
