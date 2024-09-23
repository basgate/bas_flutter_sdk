import 'dart:convert';

import 'package:bas_sdk/bas_sdk.dart';
import 'package:bas_sdk/src/sandbox_network/api_end_points.dart';
import 'package:bas_sdk/src/sandbox_network/base_api_configs.dart';
import 'package:bas_sdk/src/utils/sdk_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/util.dart';

class SandBoxApi extends BaseApiConfigs {
  Future<AuthCode> fetchAuthCode(
      {required String clientId}) async {
    try {
      final response = await dio.post(
        ApiEndPoints.fetchAuth,
        queryParameters: {'clientId': clientId},
      );

      dynamic data;

      if (response.data is Map) {
        data = jsonDecode(jsonEncode(response.data));
      } else {
        data = json.decode(response.data.toString());
      }
      return AuthCode.fromJson(data);
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      LOGW(e.toString(), 'fetchAuthCode.error');
      // LOGW(e., 'fetchAuthCode.error');

      if (e is DioException &&
          e.response?.data?.toString().isJsonString == true) {
        return AuthCode.fromJson(
            json.decode(e.response?.data.toString() ?? ''));
      }
      return AuthCode(status: 0, messages: [e.toString()]);
    }
  }

  Future<Transaction> payment({
    required final String amount,
    final String currency = 'YER',
    required final String orderId,
    required final String trxToken,
    required final String appId,
  }) async {
    try {
      final response = await dio.post(
        ApiEndPoints.payment,
        data: {
          "amount": {
            "value": amount,
            "currency": currency,
          },
          "orderId": orderId,
          "trxToken": trxToken,
          // "merchantId":me,
          "appId": appId,
        },
      );

      dynamic data;

      if (response.data is Map) {
        data = jsonDecode(jsonEncode(response.data));
      } else {
        data = json.decode(response.data.toString());
      }
      return Transaction.fromJson(data);
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      LOGW(e.toString(), '');

      if (e is DioException &&
          e.response?.data?.toString().isJsonString == true) {
        return Transaction.fromJson(
            json.decode(e.response?.data.toString() ?? ''));
      }
      return Transaction(status: 0, messages: [e.toString()]);
    }
  }
}
