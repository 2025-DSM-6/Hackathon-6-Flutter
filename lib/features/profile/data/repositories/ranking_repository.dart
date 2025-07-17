import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/ranking_modal.dart';

class RankingRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['baseURL'].toString(),
    ),
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<RankingResponse> fetchRanking() async {
    try {
      final token = await _storage.read(key: 'access_token'); // 키 이름에 맞게 수정

      final response = await _dio.get(
        '/ranking', // endpoint에 맞게 수정
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Ranking Response Status: ${response.statusCode}');
      print('Ranking Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        return RankingResponse.fromJson(data);
      } else {
        throw Exception('랭킹 데이터를 불러오지 못했습니다. status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('랭킹 요청 실패: $e');
    }
  }
}
