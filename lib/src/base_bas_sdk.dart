import 'package:bas_sdk/bas_sdk.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseBasSdk {
  // static final BaseBasSdk _singleton = BaseBasSdk.internal();
  // factory BaseBasSdk() => _singleton;
  // BaseBasSdk.internal();

  Future<BasSuperAppConfigs> onReady({
    BasMode mode = BasMode.live,
  });

  Future<AuthCode?> fetchAuthCode({
    required String clientId,
    BuildContext? context,
  });

  Future<Transaction?> payment({
    required final String amount,
    final String currency = 'YER',
    required final String orderId,
    required final String trxToken,
    required final String appId,
    BuildContext? context,
  });

  Future<LunchUrl?> basLaunchURL({required String urlToLunch});

  Future<BasSuperAppConfigs?> basConfigs();

  Future<bool?> closeMiniApp();
  Future<bool> requestLocationPermission();

  BasMode mode = BasMode.live;
}
