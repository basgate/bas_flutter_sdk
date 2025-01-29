import 'package:bas_sdk/bas_sdk.dart';
import 'package:example/models/data_to_payment.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bas SDK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bas SDK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BasSDK _basSDK = BasSDK();

  @override
  void initState() {
    super.initState();
    initBasSD();
  }

  initBasSD() async {
    var result = await _basSDK.onReady(
      mode: BasMode.sandbox,
    );
    print('onReady.result=>${result.toJson()}');
  }

  String successClientId = '453a95c0-1efa-4c9c-8341-392eb44d34f2';
  String failedClientId = '392eb44d34f2-1efa-4c9c-8341-453a95c0';

  void fetchAuthCode(String clientId) async {
    var result = await _basSDK.fetchAuthCode(
      clientId: clientId,
      context: context,
    );

    print('fetchAuthCode.result=>${result?.toJson()}');
  }

  void payment(DataToPayment data) async {
    var result = await _basSDK.payment(
      orderId: data.orderId!,
      appId: data.appId!,
      amount: data.amount!.value.toString(),
      currency: data.amount!.currency.toString(),
      trxToken: data.trxId!,
      context: context,
    );

    print('payment.result=>${result?.toJson()}');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {
        //instead of using SystemNavigator.pop() or Navigator.pop(context),
        //you can call _basSDK.closeMiniApp() to close your mini app and go back to Bas super app.

        _basSDK.closeMiniApp();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () => fetchAuthCode(successClientId),
                child: const Text('Success Auth'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                ),
                onPressed: () => fetchAuthCode(failedClientId),
                child: const Text('Failed Auth'),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () => payment(DataToPayment.success),
                child: const Text('Success Payment'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                ),
                onPressed: () => payment(DataToPayment.failed),
                child: const Text('Failed Payment'),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
