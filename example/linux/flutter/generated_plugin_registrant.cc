//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <ali_auth_plugin/ali_auth_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) ali_auth_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AliAuthPlugin");
  ali_auth_plugin_register_with_registrar(ali_auth_plugin_registrar);
}
