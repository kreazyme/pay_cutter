import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:pay_cutter/common/hive_keys.dart';

class HttpRequestResponse<T> {
  HttpRequestResponse({
    this.body,
    this.headers,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  T? body;
  Headers? headers;
  RequestOptions? request;
  int? statusCode;
  String? statusMessage;
  Map<String, dynamic>? extra;
}

@lazySingleton
class DioHelper {
  final Box _userBox;
  DioHelper({
    @Named(HiveKeys.boxName) required Box userBox,
  }) : _userBox = userBox {
    _dio = _addInterceptors(Dio());
  }

  late Dio _dio;

  Dio _addInterceptors(Dio dio) {
    final String? accessToken = _userBox.get(HiveKeys.userToken);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log('*******************');
        log('Request URL: ${options.uri} with method: ${options.method}');
        options.headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        });
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('______________________');
        log('Request URL Success: ${response.requestOptions.uri} with method: ${response.statusCode}');
        log(response.data.toString());
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        log('______________________');
        log('Request URL Failure: ${e.requestOptions.uri} with method: ${e.message}');
        return handler.next(e);
      },
    ));
    return dio;
  }

  Future<HttpRequestResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Function(int count, int total)? onSendProgress,
  }) async {
    final Response response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      options: options,
    );

    return HttpRequestResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
  }) async {
    final Response response = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }
}
