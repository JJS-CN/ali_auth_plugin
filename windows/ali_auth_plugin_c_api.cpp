#include "include/ali_auth_plugin/ali_auth_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "ali_auth_plugin.h"

void AliAuthPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  ali_auth_plugin::AliAuthPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
