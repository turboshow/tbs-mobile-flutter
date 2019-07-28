package cn.turboshow.mobile.player

import android.content.Context
import android.net.Uri
import org.videolan.libvlc.LibVLC
import org.videolan.libvlc.MediaPlayer
import org.videolan.libvlc.util.VLCVideoLayout

class TBSPlayer(context: Context, private val videoView: VLCVideoLayout) {
    private val libVLC = LibVLC(context, arrayListOf("--vout=android_display,none"))
    private val player = MediaPlayer(libVLC)

    fun play(uri: Uri) {
        player.attachViews(videoView, null, false, false)
        player.videoScale = MediaPlayer.ScaleType.SURFACE_BEST_FIT
        player.play(uri)
    }

    fun stop() {
        player.stop()
        player.detachViews()
    }

    fun release() {
        player.release()
        libVLC.release()
    }
}