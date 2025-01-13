import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_market_intent.dart';
import 'flutter_market_intent_method_channel.dart';

abstract class FlutterMarketIntentPlatform extends PlatformInterface {
  /// Constructs a FlutterMarketIntentPlatform.
  FlutterMarketIntentPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMarketIntentPlatform _instance = MethodChannelFlutterMarketIntent();

  /// The default instance of [FlutterMarketIntentPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMarketIntent].
  static FlutterMarketIntentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMarketIntentPlatform] when
  /// they register themselves.
  static set instance(FlutterMarketIntentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> openInstallApp(BuildContext context, String intent, String androidId) {
    throw UnimplementedError('openInstallApp() has not been implemented.');
  }

  Future<void> market(BuildContext context, String androidId) {
    throw UnimplementedError('market() has not been implemented.');
  }

  Future<IntentDataModel> parseIntent(BuildContext context, String intent) {
    throw UnimplementedError('parseIntent() has not been implemented.');
  }

  Future<String?> startIntent(BuildContext context, String intent) {
    throw UnimplementedError('startIntent() has not been implemented.');
  }
}
