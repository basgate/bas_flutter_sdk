import 'dart:async';
import 'model/auth_code.dart';
import 'model/sdk_config.dart';
import 'model/transaction.dart';

class BasSDK {
  static final BasSDK _singleton = BasSDK.internal();

  factory BasSDK() {
    return _singleton;
  }

  BasSDK.internal();
  Future<SDKConfig> onReady() async {
    return SDKConfig(
        locale: "en",
    );
  }
  Future<String?> currentLocale() async {
    return "en";
  }
  Future<AuthCode?> fetchAuthCode({required String clientId}) async {
    return AuthCode(
        status: -10,
        messages: ["error getting auth code out side super app!"]
    );
  }
  Future<Transaction?> payment({
    required final String amount,
    final String currency='YER',
    required final String orderId,
    required final String trxToken,
    required final String appId}) async {

    return Transaction(
        status: -10,
        messages: ["error getting payment out side super app!"]
    );
  }
}
