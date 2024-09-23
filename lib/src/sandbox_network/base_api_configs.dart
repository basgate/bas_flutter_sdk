import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_end_points.dart';

// typedef OnDecodedJsonData<T> = T Function(dynamic);

class BaseApiConfigs {
  bool enableDioLog = false;

  static Dio? _dio;

  Dio get dio {
    if (_dio == null) {
      _dio ??= Dio();
      _dio?.options = BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        headers: {
          Headers.acceptHeader: Headers.jsonContentType,
          Headers.contentTypeHeader: Headers.jsonContentType,
        },
      );

      if (enableDioLog) {
        _dio?.interceptors.add(
          LogInterceptor(
            responseBody: true,
            responseHeader: true,
            requestBody: true,
            requestHeader: true,
            error: true,
            request: true,
            logPrint: (log) {
              if (enableDioLog) {
                developer.log(log.toString());
              }
              // logger.d(log.toString(), TAG);
            },
          ),
        );
      }
    }

    return _dio!;
  }
}
