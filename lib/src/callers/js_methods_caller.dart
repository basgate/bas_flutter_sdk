import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;

import 'package:bas_sdk/bas_sdk.dart';
import 'package:bas_sdk/src/utils/js_interop.dart';

import '../utils/util.dart';

class JsMethodsCaller {
  Future<BasSuperAppConfigs> onReady() async {
    final completer = Completer<BasSuperAppConfigs>();

    try {
      LOGW("JsMethodsCaller.onReady.JSBridgeReady START",
          'JsMethodsCaller.onReady');
      html.window.addEventListener(
        'JSBridgeReady',
        (event) {
          if (completer.isCompleted) {
            return;
          }
          final messageEvent = (event as html.MessageEvent);
          Map<String, dynamic> data = messageEvent.data.cast<String, dynamic>();
          LOGW("JSBridgeReady ${data.toString()}", 'onReadyData');
          completer.complete(BasSuperAppConfigs.fromJson(data));
        },
        true,
      );
    } catch (e) {
      LOGW(e.toString(), 'JsMethodsCaller.onReady.CatchError');
      completer
          .complete(BasSuperAppConfigs(status: 0, messages: [e.toString()]));
    }

    return completer.future;
  }

  Future<AuthCode?> fetchAuthCode(
      {required String clientId, BasMode? miniAppBasMode}) async {
    final completer = Completer<AuthCode>();
    try {
      jsBridgeCall(
        "basFetchAuthCode",
        jsify({
          "clientId": clientId,
          'miniAppBasMode': miniAppBasMode?.name,
        }),
        js.allowInterop(
          (result) {
            final object = dartify(result);
            completer.complete(AuthCode.fromJson(object));
          },
        ),
      );
    } catch (e) {
      LOGW(e.toString(), 'JsMethodsCaller.fetchAuthCode.CatchError');
      if (e is NoSuchMethodError) {
        completer.complete(
          AuthCode(
            status: 0,
            messages: [
              '"Error you can NOT call fetchAuthCode out side super app!"'
            ],
          ),
        );
      } else {
        completer.complete(AuthCode(status: 0, messages: [e.toString()]));
      }
    }
    return completer.future;
  }

  Future<Transaction?> payment({
    required final String amount,
    final String currency = 'YER',
    required final String orderId,
    required final String trxToken,
    required final String appId,
    BasMode? miniAppBasMode,
  }) async {
    LOGW("Start", 'JsMethodsCaller.payment');

    final completer = Completer<Transaction>();
    try {
      jsBridgeCall(
        "basPayment",
        jsify({
          "amount": {"value": amount.toString(), "currency": currency},
          "orderId": orderId,
          "trxToken": trxToken,
          "appId": appId,
          'miniAppBasMode': miniAppBasMode?.name,
        }),
        js.allowInterop(
          (result) {
            LOGW("BasSDK Lib basPayment Return result", 'payment');
            final object = dartify(result);
            LOGW("BasSDK Lib basPayment result : $object", 'payment');
            completer.complete(Transaction.fromJson(object));
          },
        ),
      );
    } catch (e) {
      LOGW(e.toString(), 'payment.CatchError');
      if (e is NoSuchMethodError) {
        completer.complete(
          Transaction(
            status: 0,
            messages: ['Error you can NOT call payment out side super app!'],
          ),
        );
      } else {
        completer.complete(Transaction(status: 0, messages: [e.toString()]));
      }
    }

    return completer.future;
  }

  Future<LunchUrl?> basLaunchURL({required String urlToLunch}) async {
    final completer = Completer<LunchUrl>();

    try {
      jsBridgeCall(
        "basLaunchURL",
        jsify({"urlToLunch": urlToLunch}),
        js.allowInterop(
          (result) {
            final object = dartify(result);
            completer.complete(LunchUrl.fromJson(object));
          },
        ),
      );
    } catch (e) {
      LOGW(e.toString(), 'basLaunchURL.CatchError');
      if (e is NoSuchMethodError) {
        completer.complete(
          LunchUrl(
            status: 0,
            messages: ['Error you can NOT call basLaunchURL out side super app!'],
          ),
        );
      } else {
        completer.complete(LunchUrl(status: 0, messages: [e.toString()]));
      }
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
      LOGW(e.toString(), 'basConfigs.CatchError');
      if (e is NoSuchMethodError) {
        completer.complete(
          BasSuperAppConfigs(
            status: 0,
            messages: ['Error you can NOT call basConfigs out side super app!'],
          ),
        );
      } else {
        completer
            .complete(BasSuperAppConfigs(status: 0, messages: [e.toString()]));
      }
    }
    return completer.future;
  }

  Future<bool?> closeMiniApp() async {
    final completer = Completer<bool>();
    try {
      jsBridgeCall("closeMiniApp", jsify({}), js.allowInterop((result) {
        final object = dartify(result);
        completer.complete(object);
      }));
    } catch (e) {
      LOGW(e.toString(), 'closeMiniApp.CatchError');
      if (e is NoSuchMethodError) {
        completer.complete(false);
      } else {
        completer.complete(false);
      }
    }
    return completer.future;
  }
  Future<bool> requestLocationPermission() async {
    final completer = Completer<bool>();
    try {
      jsBridgeCall("requestLocationPermission", jsify({}), js.allowInterop((result) {
        final object = dartify(result);
        completer.complete(object);
      }));
    } catch (e) {
      LOGW(e.toString(), 'requestLocationPermission.CatchError');
      if (e is NoSuchMethodError) {
        completer.complete(false);
      } else {
        completer.complete(false);
      }
    }
    return completer.future;
  }
}
