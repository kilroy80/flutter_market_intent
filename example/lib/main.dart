import 'package:flutter/material.dart';

import 'package:flutter_market_intent/flutter_market_intent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterMarketIntentPlugin = FlutterMarketIntent();

  @override
  void initState() {
    super.initState();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _flutterMarketIntentPlugin.market(context, 'com.netflix.mediaclient');
                },
                child: const Text('Go Google Play Store (Netfilx)'),
              ),
              const SizedBox(height: 10.0,),
              ElevatedButton(
                onPressed: () async {
                  var data = await _flutterMarketIntentPlugin.parseIntent(
                    context, 'intent://callback?your_query_data=sample#Intent;package=YOUR.PACKAGE.IDENTIFIER;scheme=signinwithapple;end',
                  );
                  debugPrint('data = $data');
                },
                child: const Text('parse intent'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
