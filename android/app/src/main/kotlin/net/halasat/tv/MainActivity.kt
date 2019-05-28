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

        MethodChannel(flutterView, kChannelId).setMethodCallHandler { call, result ->
            if (call.method == "launchMoviePlayer") {
                // Get the arguments
                val args = call.arguments as java.util.HashMap<String, String>
                val videoUrl = args["movieUrl"] as String
                val subsUrl = args["subtitlesUrl"] as String
                val title = args["title"] as String


                val intent = Intent(this, PlayerActivity::class.java)
                val bundle = Bundle()
                bundle.putString("videoUrl", videoUrl)
                bundle.putString("subsUrl", subsUrl)
                bundle.putString("title", title)
                intent.putExtras(bundle)
                startActivity(intent)
            }
        }
    }

}
