package cn.turboshow.mobile.player

import io.flutter.plugin.common.PluginRegistry

class PlayerViewPlugin {
    companion object {
        fun registerWith(registrar: PluginRegistry.Registrar) {
            registrar
                .platformViewRegistry()
                .registerViewFactory(
                    "plugins.turboshow.cn/playerview",
                    PlayerViewFactory(registrar.messenger()))
        }
    }
}