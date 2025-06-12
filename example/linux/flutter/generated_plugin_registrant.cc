//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <device_region/device_region_plugin.h>
#include <flutter_secure_storage_linux/flutter_secure_storage_linux_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) device_region_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DeviceRegionPlugin");
  device_region_plugin_register_with_registrar(device_region_registrar);
  g_autoptr(FlPluginRegistrar) flutter_secure_storage_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterSecureStorageLinuxPlugin");
  flutter_secure_storage_linux_plugin_register_with_registrar(flutter_secure_storage_linux_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
