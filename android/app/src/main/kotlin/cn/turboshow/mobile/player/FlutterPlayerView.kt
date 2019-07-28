package cn.turboshow.mobile.player

import android.content.Context
import android.net.Uri
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import org.videolan.libvlc.util.VLCVideoLayout

class FlutterPlayerView(
    context: Context,
    messenger: BinaryMessenger,
    id: Int) : PlatformView {
    private val playerView = VLCVideoLayout(context)
    private val player = TBSPlayer(context, playerView)
    private val methodChannel = MethodChannel(messenger, "plugins.turboshow.cn/playerview_$id")

    init {
        methodChannel.setMethodCallHandler { methodCall, result ->
            when (methodCall.method) {
                "play" -> play(methodCall.arguments as String)
                else -> result.notImplemented()
            }
        }
    }

    override fun getView(): View {
        return playerView
    }

    override fun dispose() {
        player.release()
        methodChannel.setMethodCallHandler(null)
    }

    fun play(url: String) {
        player.play(Uri.parse(url))
    }
}