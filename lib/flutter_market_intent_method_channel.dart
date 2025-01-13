import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'flutter_market_intent.dart';
import 'flutter_market_intent_platform_interface.dart';

/// An implementation of [FlutterMarketIntentPlatform] that uses method channels.
class MethodChannelFlutterMarketIntent extends FlutterMarketIntentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_market_intent');

  @override
  Future<void> openInstallApp(BuildContext context, String intent, String androidId) async {
    if (Platform.isAndroid) {
      await methodChannel.invokeMethod('openOtherApp', {
        'intent': intent,
        'appId': androidId
      });
    }
  }

  @override
  Future<void> market(BuildContext context, String androidId) async {
    if (Platform.isAndroid) {
      await methodChannel.invokeMethod('market', {
        'appId': androidId
      });
    }
  }

  @override
  Future<IntentDataModel> parseIntent(BuildContext context, String intent) async {
    if (Platform.isAndroid) {
      var data = await methodChannel.invokeMethod('parseIntent', {
        'intent': intent
      });
      return IntentDataModel(
        action: data['action'] ?? '',
        categories: List<String>.from(data['categories'] as List),
        data: data['data'] ?? '',
        package: data['package'] ?? '',
      );
    }
    return IntentDataModel.empty();
  }

  @override
  Future<String?> startIntent(BuildContext context, String intent) async {
    if (Platform.isAndroid) {
      return await methodChannel.invokeMethod('startIntent', {
        'intent': intent
      });
    }
  }
}
