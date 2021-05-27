package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import net.touchcapture.qr.flutterqr.FlutterQrPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterQrPlugin.registerWith(registry.registrarFor("net.touchcapture.qr.flutterqr.FlutterQrPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
