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
                // Bundle the video information
                val bundle = Bundle()
                bundle.putString("videoUrl", videoUrl)

                // Not needed anymore
                // bundle.putString("subsUrl", subsUrl)
                // TODO: use title
                bundle.putString("title", title)

                // Pass the bundle
                intent.putExtras(bundle)
                // Start the intent
                startActivity(intent)
            }
        }
    }
}
