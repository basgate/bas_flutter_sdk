import 'dart:async';

import 'package:bas_sdk/src/model/lunch_url.dart';

import 'model/auth_code.dart';
import 'model/bas_super_app_configs.dart';
import 'model/transaction.dart';

class BasSDK {
  static final BasSDK _singleton = BasSDK.internal();

  factory BasSDK() {
    return _singleton;
  }

  BasSDK.internal();

  Future<BasSuperAppConfigs> onReady() async {
    return BasSuperAppConfigs(
      locale: "en",
    );
  }

  // Future<String?> currentLocale() async {
  //   return "en";
  // }

  Future<AuthCode?> fetchAuthCode({required String clientId}) async {
    return AuthCode(
        status: -10, messages: ["error getting auth code out side super app!"]);
  }

  Future<Transaction?> payment(
      {required final String amount,
      final String currency = 'YER',
      required final String orderId,
      required final String trxToken,
      required final String appId}) async {
    return Transaction(
        status: -10, messages: ["error getting payment out side super app!"]);
  }

  Future<LunchUrl?> basLaunchURL({required String urlToLunch}) async {
    return LunchUrl(
        status: -10, messages: ["error lunch url out side super app!"]);
  }

  Future<BasSuperAppConfigs?> basConfigs() async {
    return BasSuperAppConfigs(
        status: -10, messages: ["error in get basConfigs out side super app!"]);
  }
}
