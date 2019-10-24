package net.halasat.tv

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val kChannelId = "player-channel"


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, kChannelId).setMethodCallHandler { call, _ ->
            val args = call.arguments as java.util.HashMap<String, String>
            if (call.method == "launchMoviePlayer") {
                // Get the arguments
                val urladaptive = args["urladaptive"] as String
                val url360 = args["url360"] as String
                val url720 = args["url720"] as String
                val webvtt = args["srt"] as String
                val title = args["title"] as String
                val useTvPlayer = false


                val intent = Intent(this, PlayerActivity::class.java)

                // Bundle the video information
                val bundle = Bundle()
                bundle.putString("urladaptive", urladaptive)
                bundle.putString("ur720", url720)
                bundle.putString("url360", url360)
                bundle.putString("srt", webvtt)
                bundle.putBoolean("useTvPlayer",useTvPlayer)
                bundle.putString("title", title)

                // Pass the bundle
                intent.putExtras(bundle)
                // Start the player activity
                startActivity(intent)
            } else if (call.method == "launchChannelPlayer") {
                val videoUrl = args["channelUrl"] as String
                val title = args["title"] as String

                val intent = Intent(this, PlayerActivity::class.java)

                // Bundle the video information
                val bundle = Bundle()
                bundle.putString("videoUrl", videoUrl)
                bundle.putBoolean("useTvPlayer", true)
                bundle.putString("title", title)

                intent.putExtras(bundle)

                startActivity(intent)
            }
        }
    }
}
