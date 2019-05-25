package net.halasat.cinema

import android.os.Bundle
import android.content.Intent
import android.net.Uri
import android.os.Parcelable

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    val CHANNEL_ID = "player-channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(getFlutterView(), CHANNEL_ID).setMethodCallHandler(
                { call, result ->
                    if (call.method.equals("launchMoviePlayer")) {
                        val mxIntent = Intent(Intent.ACTION_VIEW)
                        // Get the arguments
                        val args = call.arguments as java.util.HashMap<String, String>
                        val videoUrl = Uri.parse(args["movieUrl"] as String)
                        val subUrlStr = args["subtitlesUrl"] as String
                        val title = args["title"] as String
                        // Set the data
                        mxIntent.setDataAndType(videoUrl, "application/x-mpegURL")
                        mxIntent.setPackage("com.mxtech.videoplayer.ad")
                        mxIntent.putExtra("title", title)
                        // Check for subtitles
                        if (subUrlStr != null) {
                            val subUrl = Uri.parse(subUrlStr)
                            val subParcels = arrayOf<Parcelable>(subUrl)
                            val subNames = arrayOf<String>(title)
                            // Set subtitles data
                            mxIntent.putExtra("subs", subParcels)
                            mxIntent.putExtra("subs.enable", subParcels)
                            mxIntent.putExtra("subs.name", subNames)
                        }
                        startActivity(mxIntent)
                    }
                })
    }
}
