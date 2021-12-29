
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paycardsrecognizer_sdk/flutter_paycardsrecognizer_sdk.dart';

void main() {
  runApp(const MyApp());
}

class  MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PayCardInfo? _payCardInfo;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    PayCardInfo? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
      await FlutterPayCardsRecognizerSdk.newInstance().scanCard();

    } on PlatformException {
      //platformVersion = 'Failed to get platform version.';
      print('failed');
    }


    if (!mounted) return;

    setState(() {
      _payCardInfo = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
              children: [
                Text('Running on: ${_payCardInfo?.toString() ?? 'NONE'}\n'),
                ElevatedButton(
                  onPressed: () {
                    initPlatformState();
                  },
                  child: Text('Recognize Card'),
                )
              ],
            )),
      ),
    );
  }
}