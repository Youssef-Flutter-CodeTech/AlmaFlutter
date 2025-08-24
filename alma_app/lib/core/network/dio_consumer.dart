import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:alma_app/core/constants/app_constants.dart';
import 'package:alma_app/core/network/logger.dart';
import 'package:alma_app/core/network/network_info.dart';
import 'package:alma_app/core/services/locale_service.dart';
import 'package:alma_app/core/utils/cash_helper.dart';
import 'package:alma_app/core/utils/navigation_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class DioFactory {
  final NetworkInfo internetConnectivity;
  static Dio? _dio;
  final Duration timeOut = const Duration(minutes: 30);
  final int maxRetries = 3;
  final Duration retryDelay = const Duration(seconds: 1);

  DioFactory({required this.internetConnectivity}) {
    _dio ??= Dio(
      BaseOptions(
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        sendTimeout: timeOut,
      ),
    )..interceptors.add(RetryInterceptor(
        dio: _dio!,
        maxRetries: maxRetries,
        retryDelay: retryDelay,
      ));
  }

  Future<Map<String, String>> _getHeaders({
    String? outerToken,
    String? contentType,
    Map<String, dynamic>? headers,
  }) async {
    final token = sl<CashHelper>().get(AppConstants.deviceToken);
    final language =
        NavigationService.getCurrentLocale() == Locale('ar') ? "ar" : "en";
    return headers?.cast<String, String>() ??
        {
          'Accept': 'application/json',
          'Content-Type': contentType ?? 'application/json',
          'Authorization': 'Bearer ${token ?? outerToken}',
          'X-Locale': language,
        };
  }

  Future<Either<String, Response>> _performRequest({
    required String method,
    required String url,
    Object? body,
    String? contentType,
    String? outerToken,
    Map<String, dynamic>? headers,
    FormData? formData,
  }) async {
    try {
      if (await internetConnectivity.isConnected) {
        final requestHeaders = await _getHeaders(
          outerToken: outerToken,
          contentType: contentType,
          headers: headers,
        );
        final data = formData ?? (body != null ? json.encode(body) : null);
        Logger.logRequest(
          method: method,
          url: url,
          headers: requestHeaders,
          body: data?.toString() ?? body?.toString(),
        );
        final stopwatch = Stopwatch()..start();
        final response = await _dio!.request(
          url,
          data: data,
          options: Options(
            method: method,
            headers: requestHeaders,
          ),
        );
        stopwatch.stop();
        Logger.logResponse(
          statusCode: response.statusCode ?? 0,
          body: response.data.toString(),
          duration: stopwatch.elapsed,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(response);
        } else {
          return Left(_handleErrorResponse(response));
        }
      }
      return const Left('No internet Connection');
    } catch (e) {
      Logger.logError(e);
      return Left(_handleException(e));
    }
  }

  Future<Either<String, Response>> getRequest({
    required String url,
    Object? body,
    String? contentType,
    String? outerToken,
    Map<String, dynamic>? headers,
  }) async {
    return _performRequest(
      method: 'GET',
      url: url,
      body: body,
      contentType: contentType,
      outerToken: outerToken,
      headers: headers,
    );
  }

  Future<Either<String, Response>> postRequest({
    required String url,
    Object? body,
    String? contentType,
    String? outerToken,
    Map<String, dynamic>? headers,
  }) async {
    return _performRequest(
      method: 'POST',
      url: url,
      body: body,
      contentType: contentType,
      outerToken: outerToken,
      headers: headers,
    );
  }

  Future<Either<String, Response>> multipartRequest({
    required String url,
    Object? body,
    String? contentType,
    String? outerToken,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (await internetConnectivity.isConnected) {
        if (contentType == 'multipart/form-data' &&
            body is Map<String, dynamic>) {
          final formData = FormData();
          for (var entry in body.entries) {
            final key = entry.key;
            final value = entry.value;
            if (value is File) {
              formData.files.add(MapEntry(
                key,
                await MultipartFile.fromFile(
                  value.path,
                  filename: value.uri.pathSegments.last,
                ),
              ));
            } else {
              formData.fields.add(MapEntry(key, value.toString()));
            }
          }
          return _performRequest(
            method: 'POST',
            url: url,
            formData: formData,
            contentType: contentType,
            outerToken: outerToken,
            headers: headers,
          );
        } else {
          return _performRequest(
            method: 'POST',
            url: url,
            body: body,
            contentType: contentType,
            outerToken: outerToken,
            headers: headers,
          );
        }
      }
      return const Left('No internet Connection');
    } catch (e) {
      Logger.logError(e);
      return Left(_handleException(e));
    }
  }

  Future<Either<String, Response>> putRequest({
    required String url,
    Object? body,
    String? contentType,
    String? outerToken,
    Map<String, dynamic>? headers,
  }) async {
    return _performRequest(
      method: 'PUT',
      url: url,
      body: body,
      contentType: contentType,
      outerToken: outerToken,
      headers: headers,
    );
  }

  Future<Either<String, Response>> deleteRequest({
    required String url,
    Object? body,
    String? contentType,
    String? outerToken,
    Map<String, dynamic>? headers,
  }) async {
    return _performRequest(
      method: 'DELETE',
      url: url,
      body: body,
      contentType: contentType,
      outerToken: outerToken,
      headers: headers,
    );
  }

  String _handleErrorResponse(Response response) {
    try {
      final body =
          response.data is String ? json.decode(response.data) : response.data;
      return body['message'] ??
          body['title'] ??
          body['Message'] ??
          body['errors'] ??
          'Server Error';
    } catch (e) {
      return 'Server Error';
    }
  }

  String _handleException(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return 'Connection timeout';
      } else if (error.type == DioExceptionType.badResponse) {
        return _handleErrorResponse(error.response!);
      }
    }
    return 'Unexpected error occurred';
  }
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    required this.dio,
    required this.maxRetries,
    required this.retryDelay,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retry_count'] ?? 0;

    // Check if the error is retryable and retries are not exhausted
    if (retryCount < maxRetries && _shouldRetry(err)) {
      LoggerExtension.logRetry(
        attempt: retryCount + 1,
        maxRetries: maxRetries,
        url: err.requestOptions.uri.toString(),
        error: err,
      );

      // Update retry count
      err.requestOptions.extra['retry_count'] = retryCount + 1;

      // Delay before retrying
      await Future.delayed(retryDelay);

      try {
        // Retry the request
        final response = await dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            extra: err.requestOptions.extra,
          ),
        );
        handler.resolve(response);
      } catch (e) {
        handler.reject(err);
      }
    } else {
      handler.reject(err);
    }
  }

  bool _shouldRetry(DioException err) {
    // Retry on timeout errors or specific HTTP status codes (e.g., 503)
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return true;
    }
    if (err.response != null && err.response!.statusCode == 503) {
      return true;
    }
    return false;
  }
}
