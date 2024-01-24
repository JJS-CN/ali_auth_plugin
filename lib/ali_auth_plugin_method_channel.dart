import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../ali_auth_plugin_platform_interface.dart';
import 'ali_auth_ui_config.dart';

/// An implementation of [AliAuthPluginPlatform] that uses method channels.
class MethodChannelAliAuthPlugin extends AliAuthPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ali_auth_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getSdkVersion() async {
    final version = await methodChannel.invokeMethod<String?>('getSdkVersion');
    return version;
  }

  @override
  Future<bool> setAuthSDKInfo(
      String androidAppSecret, String iosAppSecret) async {
    final setAuthSDKInfo = await methodChannel.invokeMethod<bool>(
        'setAuthSDKInfo',
        {"androidAppSecret": androidAppSecret, "iosAppSecret": iosAppSecret});
    return setAuthSDKInfo ?? false;
  }

  @override
  Future<bool> checkEnvAvailable() async {
    final checkEnvAvailable =
        await methodChannel.invokeMethod<bool>('checkEnvAvailable');
    return checkEnvAvailable ?? false;
  }

  @override
  Future<String?> getLoginToken({AuthUiConfig? uiConfig}) {
    final getLoginToken = methodChannel.invokeMethod<String?>(
        'getLoginToken', jsonEncode(uiConfig?.toJson()));
    return getLoginToken;
  }
}
