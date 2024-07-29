import 'dart:async';
import 'dart:js' as js;
import 'dart:html' as html;

import 'model/auth_code.dart';
import 'model/sdk_config.dart';
import 'model/transaction.dart';
import 'utils/js_interop.dart';
import 'utils/util.dart';

class BasSDK {
  static final BasSDK _singleton = new BasSDK.internal();

  //bool _isReady=false;

  factory BasSDK() {
    return _singleton;
  }

  BasSDK.internal();

  Future<SDKConfig> onReady() async {
    final completer = Completer<SDKConfig>();
    //html.window.ad
    html.window.addEventListener('JSBridgeReady', (event) {
      if (completer.isCompleted) return;
      print("JSBridgeReady");
      final messageEvent = (event as html.MessageEvent);
      Map<String, dynamic> data = messageEvent.data.cast<String, dynamic>();
      print("JSBridgeReady ${data.toString()}");
      completer.complete(SDKConfig.fromJson(data));
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
    jsBridgeCall("basFetchAuthCode", jsify({"clientId": clientId}),
        js.allowInterop((result) {
      final object = dartify(result);
      //AppLog.pdebug("----- ${object}");
      completer.complete(AuthCode.fromJson(object));
    }));
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
    try {
      jsBridgeCall(
          "basPayment",
          jsify({
            "amount": {"value": amount, "currency": currency},
            "orderId": orderId,
            "trxToken": trxToken,
            "appId": appId
          }), js.allowInterop((result) {
        LOGW("-----BasSDK Lib basPayment Return result");
        final object = dartify(result);
        LOGW("-----BasSDK Lib basPayment result : $object");
        completer.complete(Transaction.fromJson(object));
      },

      ));
    } on Exception catch (e) {
      LOGW("-----BasSDK Lib basPayment ERROR :${e.toString()}");
    }
    return completer.future;
  }

  void dispose() {
    //headlessWebView?.dispose();
  }
}
