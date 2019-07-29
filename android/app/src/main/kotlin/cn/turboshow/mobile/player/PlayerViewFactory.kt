package cn.turboshow.mobile.player

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class PlayerViewFactory(private val registrar: PluginRegistry.Registrar) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, params: Any?): PlatformView {
        return FlutterPlayerView(registrar.activity(), registrar.messenger(), id)
    }

}