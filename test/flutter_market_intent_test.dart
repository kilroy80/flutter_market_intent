import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_market_intent/flutter_market_intent.dart';
import 'package:flutter_market_intent/flutter_market_intent_platform_interface.dart';
import 'package:flutter_market_intent/flutter_market_intent_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMarketIntentPlatform
    with MockPlatformInterfaceMixin
    implements FlutterMarketIntentPlatform {

  @override
  Future<void> market(BuildContext context, String androidId) {
    throw UnimplementedError();
  }

  @override
  Future<void> openInstallApp(BuildContext context, String intent, String androidId) {
    throw UnimplementedError();
  }

  @override
  Future<IntentDataModel> parseIntent(BuildContext context, String intent) {
    throw UnimplementedError();
  }
}

void main() {
  final FlutterMarketIntentPlatform initialPlatform = FlutterMarketIntentPlatform.instance;

  test('$MethodChannelFlutterMarketIntent is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterMarketIntent>());
  });

  // test('getPlatformVersion', () async {
  //   FlutterMarketIntent flutterMarketIntentPlugin = FlutterMarketIntent();
  //   MockFlutterMarketIntentPlatform fakePlatform = MockFlutterMarketIntentPlatform();
  //   FlutterMarketIntentPlatform.instance = fakePlatform;
  //
  //   expect(await flutterMarketIntentPlugin.getPlatformVersion(), '42');
  // });
}
