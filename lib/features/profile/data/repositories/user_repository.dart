import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_6_flutter/core/const/data.dart';

import '../models/user_model.dart';

class UserRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['baseURL'] ?? '',
    ),
  );

  Future<UserModel> fetchUser() async {
    try {
      final token = await _storage.read(key: accessTokenKey);
      final response = await _dio.get(
        '/user',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');
      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        return UserModel.fromJson(data);
      } else {
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("유저 정보를 불러오는데 실패했습니다 $e");
    }
  }
}
