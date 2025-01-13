export 'package:flutter_market_intent/src/model/intent_data_model.dart';

import 'package:flutter/widgets.dart';

import 'flutter_market_intent.dart';
import 'flutter_market_intent_platform_interface.dart';

class FlutterMarketIntent {
  Future<void> openInstallApp(BuildContext context, String intent, String androidId) async {
    return FlutterMarketIntentPlatform.instance.openInstallApp(context, intent, androidId);
  }

  Future<void> market(BuildContext context, String androidId) async {
    return FlutterMarketIntentPlatform.instance.market(context, androidId);
  }

  Future<IntentDataModel> parseIntent(BuildContext context, String intent) async {
    return FlutterMarketIntentPlatform.instance.parseIntent(context, intent);
  }

  Future<String?> startIntent(BuildContext context, String intent) {
    return FlutterMarketIntentPlatform.instance.startIntent(context, intent);
  }
}
