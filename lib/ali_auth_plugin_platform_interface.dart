import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ali_auth_plugin_method_channel.dart';
import 'ali_auth_ui_config.dart';

abstract class AliAuthPluginPlatform extends PlatformInterface {
  /// Constructs a AliAuthPluginPlatform.
  AliAuthPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static AliAuthPluginPlatform _instance = MethodChannelAliAuthPlugin();

  /// The default instance of [AliAuthPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelAliAuthPlugin].
  static AliAuthPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AliAuthPluginPlatform] when
  /// they register themselves.
  static set instance(AliAuthPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getSdkVersion() {
    throw UnimplementedError('getSdkVersion() has not been implemented.');
  }

  Future<bool> setAuthSDKInfo(String androidAppSecret, String iosAppSecret) {
    throw UnimplementedError('setAuthSDKInfo() has not been implemented.');
  }

  Future<bool> checkEnvAvailable() {
    throw UnimplementedError('checkLogin() has not been implemented.');
  }

  Future<String?> getLoginToken({AuthUiConfig? uiConfig}) {
    throw UnimplementedError('getLoginToken() has not been implemented.');
  }
}
