import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_6_flutter/core/const/data.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['baseURL'] ?? '',
    ),
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth', data: {
        "account_id": username,
        "password": password,
      });

      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        if (token != null) {
          await _storage.write(key: accessTokenKey, value: token);
          return true;
        }
      }
    } on DioException catch (e) {
      print('Login failed: ${e.response?.data ?? e.message}');
    } catch (e) {
      print('Unexpected error during login: $e');
    }
    return false;
  }

  Future<String?> getToken() async {
    return await _storage.read(key: accessTokenKey);
  }

  Future<void> logout() async {
    await _storage.delete(key: accessTokenKey);
  }
}