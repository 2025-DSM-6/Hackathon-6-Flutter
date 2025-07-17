import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../core/const/data.dart';

final Dio dio = Dio();

void dioInit() => dio.interceptors.add(CustomInterceptors());

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.read(key: accessTokenKey);
    if (token != null) {
      options.headers['authorization'] = 'Bearer $token';
    }

    debugPrint('[REQ] ${options.method} ${options.uri}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    debugPrint('[ERR] Status Code: ${err.response?.statusCode}');
    debugPrint('[ERR] Response Data: ${err.response?.data}');
    return handler.reject(err);
  }
}
