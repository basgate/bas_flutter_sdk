import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;

import 'model/auth_code.dart';
import 'model/lunch_url.dart';
import 'model/bas_super_app_configs.dart';
import 'model/transaction.dart';
import 'utils/js_interop.dart';
import 'utils/util.dart';

class BasSDK {
  static final BasSDK _singleton = BasSDK.internal();

  //bool _isReady=false;

  factory BasSDK() {
    return _singleton;
  }

  BasSDK.internal();

  Future<BasSuperAppConfigs> onReady() async {
    final completer = Completer<BasSuperAppConfigs>();
    //html.window.ad
    html.window.addEventListener('JSBridgeReady', (event) {
      if (completer.isCompleted) {
        return;
      }
      print("JSBridgeReady");
      final messageEvent = (event as html.MessageEvent);
      Map<String, dynamic> data = messageEvent.data.cast<String, dynamic>();
      print("JSBridgeReady ${data.toString()}");
      completer.complete(BasSuperAppConfigs.fromJson(data));
    }, true);
    return completer.future;
  }

  // Future<String?> currentLocale() async {
  //   final completer=Completer<String?>();
  //   jsBridgeCall("basCurrentLocale",  jsify({}),js.allowInterop((result){
  //     final object=dartify(result);
  //     print("----- ${object}");
  //     completer.complete(object["data"]["locale"]);
  //   }));
  //   return completer.future;
  // }

  Future<AuthCode?> fetchAuthCode({required String clientId}) async {
    final completer = Completer<AuthCode>();
    // jsBridgeCall("basFetchAuthCode", jsify({"clientId": clientId}),js.allowInterop((result){
    //   final object=dartify(result);
    //   //AppLog.pdebug("----- ${object}");
    //   completer.complete(AuthCode.fromJson(object));
    // }));
    // return completer.future;
    try {
      jsBridgeCall("basFetchAuthCode", jsify({"clientId": clientId}),
          js.allowInterop((result) {
        final object = dartify(result);
        //AppLog.pdebug("----- ${object}");
        completer.complete(AuthCode.fromJson(object));
      }));
    } catch (e) {
      completer.complete(AuthCode(status: 0, messages: [e.toString()]));
    }
    return completer.future;
  }

  Future<Transaction?> payment(
      {required final String amount,
      final String currency = 'YER',
      required final String orderId,
      required final String trxToken,
      required final String appId}) async {
    LOGW("-----BasSDK Lib START basPayment -------");
    LOGW(
        "amount :$amount , currency :$currency , orderId :$orderId , trxToken :$trxToken , appId :$appId");

    final completer = Completer<Transaction>();
    // jsBridgeCall("basPayment",
    //     jsify({
    //       "amount": {
    //         "value":amount.toString(),
    //         "currency": currency
    //       },
    //       "orderId": orderId,
    //       "trxToken": trxToken,
    //       "appId": appId
    //     }),
    //     js.allowInterop((result){
    //       LOGW("-----BasSDK Lib basPayment Return result");
    //       final object=dartify(result);
    //       LOGW("-----BasSDK Lib basPayment result : $object");
    //       completer.complete(Transaction.fromJson(object));
    //     })
    // );
    // return completer.future;

    try {
      jsBridgeCall(
          "basPayment",
          jsify({
            "amount": {"value": amount.toString(), "currency": currency},
            "orderId": orderId,
            "trxToken": trxToken,
            "appId": appId
          }), js.allowInterop((result) {
        LOGW("-----BasSDK Lib basPayment Return result");
        final object = dartify(result);
        LOGW("-----BasSDK Lib basPayment result : $object");
        completer.complete(Transaction.fromJson(object));
      }));
    } catch (e) {
      completer.complete(Transaction(status: 0, messages: [e.toString()]));
    }

    return completer.future;
  }

  Future<LunchUrl?> basLaunchURL({required String urlToLunch}) async {
    final completer = Completer<LunchUrl>();

    try {
      jsBridgeCall("basLaunchURL", jsify({"urlToLunch": urlToLunch}),
          js.allowInterop((result) {
        final object = dartify(result);
        completer.complete(LunchUrl.fromJson(object));
      }));
    } catch (e) {
      completer.complete(LunchUrl(status: 0, messages: [e.toString()]));
    }
    return completer.future;
  }

  Future<BasSuperAppConfigs?> currentLocale() async {
    final completer = Completer<BasSuperAppConfigs>();

    try {
      jsBridgeCall("basCurrentLocale", jsify({}), js.allowInterop((result) {
        final object = dartify(result);
        completer.complete(BasSuperAppConfigs.fromJson(object));
      }));
    } catch (e) {
      completer.complete(BasSuperAppConfigs(status: 0, messages: [e.toString()]));
    }
    return completer.future;
  }

  Future<BasSuperAppConfigs?> basConfigs() async {
    final completer = Completer<BasSuperAppConfigs>();

    try {
      jsBridgeCall("basConfigs", jsify({}), js.allowInterop((result) {
        final object = dartify(result);
        completer.complete(BasSuperAppConfigs.fromJson(object));
      }));
    } catch (e) {
      completer.complete(BasSuperAppConfigs(status: 0, messages: [e.toString()]));
    }
    return completer.future;
  }

  void dispose() {
    //headlessWebView?.dispose();
  }
}
