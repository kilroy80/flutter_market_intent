package com.kinosoft.flutter_market_intent

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.ComponentName
import android.content.Intent
import android.content.pm.ActivityInfo
import android.content.pm.ResolveInfo
import android.net.Uri
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterMarketIntentPlugin */
class FlutterMarketIntentPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext

    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_market_intent")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "openInstallApp") {

      val intent: String = call.argument("intent") ?: ""
      val appId: String = call.argument("appId") ?: ""
      val existPackage = context.packageManager.getLaunchIntentForPackage(appId)
      if (existPackage != null) {
        context.startActivity(Intent.parseUri(intent, Intent.URI_INTENT_SCHEME))
      } else {
        launchMarket(appId)
      }
      result.success(null)

    } else if (call.method == "market") {
      var appId: String? = call.argument("appId")
      if (appId == null) {
        appId = context.packageName
      }

      launchMarket(appId ?: "")
      result.success(null)

    } else if (call.method == "parseIntent") {

      val intent: String = call.argument("intent") ?: ""
      val i = Intent.parseUri(intent, Intent.URI_INTENT_SCHEME)

      val hashMap = HashMap<String, Any>()
      hashMap["action"] = i.action ?: ""
      hashMap["categories"] = if (i.categories != null) ArrayList<String>(i.categories) else ArrayList<String>()
      hashMap["data"] = i.dataString ?: ""
      hashMap["package"] = i.`package` ?: ""

      result.success(hashMap)

    } else if (call.method == "startIntent") {

      val intent: String = call.argument("intent") ?: ""
      val i = Intent.parseUri(intent, Intent.URI_INTENT_SCHEME)

      try {
        val existPackage = context.packageManager.getLaunchIntentForPackage(i.`package` ?: "")
        if (existPackage != null) {
          context.startActivity(i)
          result.success(null)
        } else {
          val fallbackUrl = i.getStringExtra("browser_fallback_url") ?: ""
          if (fallbackUrl != "") {
            result.success(fallbackUrl)
          } else {
            result.success(null)
          }
        }
      } catch (e: Exception) {
        val fallbackUrl = i.getStringExtra("browser_fallback_url") ?: ""
        if (fallbackUrl != "") {
          result.success(fallbackUrl)
        } else {
          result.success(null)
        }
      }

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun launchMarket(appId: String) {
    val rateIntent = Intent(
      Intent.ACTION_VIEW,
      Uri.parse("market://details?id=$appId")
    )
    var marketFound = false

    val otherApps: List<ResolveInfo> = context.packageManager
      .queryIntentActivities(rateIntent, 0)
    for (otherApp in otherApps) {
      if (otherApp.activityInfo.applicationInfo.packageName
          .equals("com.android.vending")
      ) {
        val otherAppActivity: ActivityInfo = otherApp.activityInfo
        val componentName = ComponentName(
          otherAppActivity.applicationInfo.packageName,
          otherAppActivity.name
        )
        rateIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        rateIntent.addFlags(Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED)
        rateIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        rateIntent.component = componentName

        context.startActivity(rateIntent)
        marketFound = true
        break
      }
    }

    if (!marketFound) {
      try {
        context.startActivity(
          Intent(
            Intent.ACTION_VIEW,
            Uri.parse("market://details?id=$appId")
          )
        )
      } catch (e: ActivityNotFoundException) {
        context.startActivity(
          Intent(
            Intent.ACTION_VIEW,
            Uri.parse("https://play.google.com/store/apps/details?id=$appId")
          )
        )
      }
    }
  }
}
