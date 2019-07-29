package cn.turboshow.mobile.player

import android.content.Context
import android.net.Uri
import org.videolan.libvlc.LibVLC
import org.videolan.libvlc.MediaPlayer
import org.videolan.libvlc.util.VLCVideoLayout

class TBSPlayer(private val context: Context, private val videoView: VLCVideoLayout) {
    private val libVLC = LibVLC(context, arrayListOf())
    private val player = MediaPlayer(libVLC)

    fun play(uri: Uri) {
        player.run {
            videoScale = MediaPlayer.ScaleType.SURFACE_BEST_FIT
            attachViews(videoView, null, false, false)
            videoView.viewTreeObserver.addOnGlobalLayoutListener {
                vlcVout.setWindowSize(videoView.width, videoView.height)
            }
            play(uri)
        }
    }

    fun stop() {
        player.stop()
        player.detachViews()
    }

    fun release() {
        player.release()
        libVLC.release()
    }

    companion object {

    }
}