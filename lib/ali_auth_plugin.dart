import '../ali_auth_plugin_platform_interface.dart';
import 'ali_auth_ui_config.dart';

class AliAuthPlugin {
  Future<String?> getPlatformVersion() {
    return AliAuthPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> getSdkVersion() {
    return AliAuthPluginPlatform.instance.getSdkVersion();
  }

  Future<bool> setAuthSDKInfo(String androidAppSecret, String iosAppSecret) {
    return AliAuthPluginPlatform.instance
        .setAuthSDKInfo(androidAppSecret, iosAppSecret);
  }

  Future<bool> checkEnvAvailable() {
    return AliAuthPluginPlatform.instance.checkEnvAvailable();
  }

  Future<String?> getLoginToken({AuthUiConfig? uiConfig}) {
    return AliAuthPluginPlatform.instance.getLoginToken(uiConfig: uiConfig);
  }

  Future<bool> quitLoginPage() {
    return AliAuthPluginPlatform.instance.quitLoginPage();
  }
}
