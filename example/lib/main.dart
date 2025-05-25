import 'package:bas_sdk/bas_sdk.dart';
import 'package:example/models/data_to_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_json_view/flutter_json_view.dart';

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

  Map<String, dynamic>? response;
  bool? isSuccessResponse;

  @override
  void initState() {
    super.initState();
    initBasSD();
  }

  initBasSD() async {
    var result = await _basSDK.onReady(
      mode: BasMode.live,
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

    setState(() {
      isSuccessResponse = result?.status == 1;
      response = result?.toJson();
    });
  }

  payment(DataToPayment data) async {
    Transaction? result = await _basSDK.payment(
      orderId: data.orderId!,
      appId: data.appId!,
      amount: data.amount!.value.toString(),
      currency: data.amount!.currency.toString(),
      trxToken: data.trxId!,
      context: context,
    );
    print('payment.result=>${result?.toJson()}');
    setState(() {
      isSuccessResponse = result?.status == 1;
      response = result?.toJson();
    });
  }

  requestLocationPermission() async {
    bool result = await _basSDK.requestLocationPermission();
    print('requestLocationPermission.result=>$result');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Location permission ${result ? 'granted' : 'denied'}',
        ),
        backgroundColor: result ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {
        //instead of using SystemNavigator.pop() or Navigator.pop(context),
        //you can call _basSDK.closeMiniApp() to close your mini app and go back to Bas super app.
        print('called onPopInvoked with basSdk');
        _basSDK.closeMiniApp();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () => fetchAuthCode(successClientId),
                    child: const Text('Success Auth'),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                    ),
                    onPressed: () => fetchAuthCode(failedClientId),
                    child: const Text('Failed Auth'),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () => payment(DataToPayment.success),
                    child: const Text('Success Payment'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                    ),
                    onPressed: () => payment(DataToPayment.failed),
                    child: const Text('Failed Payment'),
                  ),
                ],
              ),
              const Divider(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: requestLocationPermission,
                child: const Text('Request Location Permission'),
              ),
              const Divider(),
              Expanded(
                child: JsonViewerWidget(
                  isSuccess: isSuccessResponse,
                  response: response,
                  // isSuccess: failedResponse == null && successResponse == null,
                  onClear: () => setState(() {
                    isSuccessResponse = null;
                    response = null;
                  }),
                ),
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class JsonViewerWidget extends StatelessWidget {
  final bool? isSuccess;
  final Map<String, dynamic>? response;
  final VoidCallback onClear;

  const JsonViewerWidget(
      {super.key,
      this.response,
      required this.onClear,
      required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              isSuccess == null
                  ? 'Response'
                  : (isSuccess! ? 'Success Response' : 'Failed Response'),
              style: TextStyle(
                fontSize: 18.0,
                color: isSuccess == null
                    ? null
                    : (isSuccess! ? Colors.green : Colors.red),
              ),
            ),
            const Spacer(),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              radius: 8.0,
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(
                    text: response.toString(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Icon(Icons.copy),
              ),
            ),
            const SizedBox(width: 8.0),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              radius: 8.0,
              onTap: onClear,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Icon(
                  Icons.delete_sweep_outlined,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: JsonView.map(response ?? {}),
        ),
      ],
    );
  }
}
