import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_market_intent/flutter_market_intent_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterMarketIntent platform = MethodChannelFlutterMarketIntent();
  const MethodChannel channel = MethodChannel('flutter_market_intent');

  // setUp(() {
  //   TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
  //     channel,
  //     (MethodCall methodCall) async {
  //       return '42';
  //     },
  //   );
  // });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await platform.getPlatformVersion(), '42');
  // });
}
