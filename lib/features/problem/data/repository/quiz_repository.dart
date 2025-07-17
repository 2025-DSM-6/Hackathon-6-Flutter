import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_6_flutter/core/const/data.dart';
import 'package:flutter/foundation.dart';

import '../model/quiz_model.dart';

class QuizRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Dio _aiDio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['AIBaseURL'].toString(),
    ),
  );
  final Dio _mainDio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['baseURL'].toString(),
    ),
  );

  Future<QuizModel> fetchQuiz(String subject, String scope) async {
    try {
      final token = await _storage.read(key: accessTokenKey);
      final response = await _aiDio.post(
        '/generate-question',
        data: {"subject": subject, "scope": scope},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        return QuizModel.fromJson(data);
      } else {
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("[ERROR] $e");
    }
  }

  Future<void> submitAnswer({
    required String userId,
    required int questionId,
    required String answer,
    required bool usedHint,
  }) async {
    try {
      final token = await _storage.read(key: accessTokenKey);
      debugPrint('[DEBUG] Access Token: $token');
      final response = await _mainDio.post(
        'api/submit-answer',
        data: {
          "user_id": userId,
          "question_id": questionId,
          "answer": answer,
          "used_hint": usedHint,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode != 200) {
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("[ERROR] $e");
    }
  }

  Future<void> shareProblem({
    required int questionId,
  }) async {
    try {
      final token = await _storage.read(key: accessTokenKey);
      final response = await _mainDio.post(
        '/share-question',
        data: {
          "question_id": questionId.toString(),
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode != 200) {
        throw Exception("서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("[ERROR] $e");
    }
  }
}
