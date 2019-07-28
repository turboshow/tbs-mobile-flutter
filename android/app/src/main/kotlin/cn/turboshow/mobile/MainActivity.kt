package cn.turboshow.mobile

import android.os.Bundle
import cn.turboshow.mobile.player.PlayerViewPlugin

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    PlayerViewPlugin.registerWith(this.registrarFor(PlayerViewPlugin::class.java.canonicalName))
  }
}
