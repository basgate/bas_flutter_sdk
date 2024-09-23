// import 'dart:async';
//
// import 'package:bas_sdk/bas_sdk.dart';
// import 'package:bas_sdk/src/callers/js_methods_caller.dart';
// import 'package:bas_sdk/src/sandbox_network/sandbox_api.dart';
// import 'package:bas_sdk/src/utils/ui_heper.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'base_bas_sdk.dart';
// import 'utils/util.dart';

import 'dart:async';

import 'package:bas_sdk/bas_sdk.dart';
import 'package:bas_sdk/src/sandbox_network/sandbox_api.dart';
import 'package:flutter/material.dart';

import 'base_bas_sdk.dart';
import 'callers/js_methods_caller.dart';
import 'utils/ui_heper.dart';
import 'utils/util.dart';

class BasSDK extends BaseBasSdk {
  static final BasSDK _singleton = BasSDK.internal();

  factory BasSDK() => _singleton;

  BasSDK.internal();

  //error type when not in bas app is => JSNoSuchMethodError

  final JsMethodsCaller _jsMethodsCaller = JsMethodsCaller();
  final SandBoxApi _sandBoxApi = SandBoxApi();

  @override
  Future<BasSuperAppConfigs> onReady({BasMode mode = BasMode.live}) async {
    super.mode = mode;

    LOGW("onReady START in ${super.mode.name}", 'onReady');
    if (mode == BasMode.sandbox) {
      return BasSuperAppConfigs(status: 1, envType: BasMode.sandbox);
    } else {
      BasSuperAppConfigs result = await _jsMethodsCaller.onReady();
      LOGW("onReadyResult ${result.toJson()}", 'onReady');
      return result;
    }
  }

  /*Future<BasSuperAppConfigs> onReady({BasMode mode = BasMode.live}) async {
    final completer = Completer<BasSuperAppConfigs>();
    print("JSBridgeReady Start");
    try {
    //html.window.ad
    html.window.addEventListener(
      'JSBridgeReady',
      (event) {
        if (completer.isCompleted) {
          return;
        }
        print("JSBridgeReady");
        final messageEvent = (event as html.MessageEvent);
        Map<String, dynamic> data = messageEvent.data.cast<String, dynamic>();
        print("JSBridgeReady data ${data.toString()}");
        completer.complete(BasSuperAppConfigs.fromJson(data));
      },
      true,
    );
    } catch (e) {
      print("JSBridgeReady catch.error=> ${e.toString()}");
      completer.complete(BasSuperAppConfigs(status: 0, messages: ['error']));
    }

    return completer.future;
  }*/

  @override
  Future<AuthCode?> fetchAuthCode({
    required String clientId,
    BuildContext? context,
  }) async {
    assert(mode == BasMode.sandbox && context != null,
        'context can not be null on sandbox mode');

    LOGW("fetchAuthCode START in ${mode.name}", 'fetchAuthCode');

    if (mode == BasMode.sandbox) {
      UiHelper.buildDialog(context!);
      AuthCode result = await _sandBoxApi.fetchAuthCode(clientId: clientId);
      UiHelper.closeDialog();
      return result;
    } else {
      return await _jsMethodsCaller.fetchAuthCode(
          clientId: clientId, miniAppBasMode: mode);
    }
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
    assert(mode == BasMode.sandbox && context != null,
        'context can not be null on sandbox mode');

    LOGW("basPayment START in ${mode.name}", 'payment');
    LOGW(
        "amount:$amount, currency:$currency, orderId:$orderId, trxToken:$trxToken, appId:$appId",
        'payment');

    if (mode == BasMode.sandbox) {
      // UiHelper.buildDialog(context!);
      // await Future.delayed(const Duration(seconds: 3));
      await UiHelper.buildBottomSheet(context!);
      UiHelper.buildDialog(context!);
      Transaction result = await _sandBoxApi.payment(
        trxToken: trxToken,
        amount: amount,
        currency: currency,
        appId: appId,
        orderId: orderId,
      );
      UiHelper.closeDialog();
      return result;
    } else {
      return await _jsMethodsCaller.payment(
        trxToken: trxToken,
        amount: amount,
        currency: currency,
        appId: appId,
        orderId: orderId,
        miniAppBasMode: mode,
      );
    }
  }

  @override
  Future<LunchUrl?> basLaunchURL({required String urlToLunch}) async {
    LOGW("basLaunchURL START in ${mode.name}", 'basLaunchURL');
    return await _jsMethodsCaller.basLaunchURL(urlToLunch: urlToLunch);
  }

  @override
  Future<BasSuperAppConfigs?> basConfigs() async {
    LOGW("basConfigs START in ${mode.name}", 'basConfigs');
    return await _jsMethodsCaller.basConfigs();
  }

  void dispose() {
    //headlessWebView?.dispose();
  }
}
