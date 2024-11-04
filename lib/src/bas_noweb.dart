import 'dart:async';

import 'package:bas_sdk/bas_sdk.dart';
import 'package:flutter/material.dart';

import 'base_bas_sdk.dart';

class BasSDK extends BaseBasSdk {
  static final BasSDK _singleton = BasSDK.internal();

  factory BasSDK() {
    return _singleton;
  }

  BasSDK.internal();

  @override
  Future<BasSuperAppConfigs> onReady({BasMode mode = BasMode.live}) async {
    return BasSuperAppConfigs(
      locale: "en",
    );
  }

  @override
  Future<AuthCode?> fetchAuthCode(
      {required String clientId, BuildContext? context}) async {
    return AuthCode(
      status: -10,
      messages: ['Error call fetchAuthCode out side super app!'],
    );
  }

  @override
  Future<Transaction?> payment({
    required final String amount,
    final String currency = 'YER',
    required final String orderId,
    required final String trxToken,
    required final String appId,
    BuildContext? context,
  }) async {
    return Transaction(
      status: -10,
      messages: ['Error call payment out side super app!'],
    );
  }

  @override
  Future<LunchUrl?> basLaunchURL({required String urlToLunch}) async {
    return LunchUrl(
      status: -10,
      messages: ['Error call basLaunchURL out side super app!'],
    );
  }

  @override
  Future<BasSuperAppConfigs?> basConfigs() async {
    return BasSuperAppConfigs(
      status: -10,
      messages: ['Error call basConfigs out side super app!'],
    );
  }

  @override
  Future<bool?> closeMiniApp() async {
    return true;
  }
}
