import UIKit
import Flutter
import AVFoundation
import AVKit
import AVPlayerViewControllerSubtitles

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let moviePlayerChannel = FlutterMethodChannel(name: "player-channel",
                                             binaryMessenger: controller)
    moviePlayerChannel.setMethodCallHandler ({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if call.method == "launchMoviePlayer" {
            // Check if arguments are provided
            guard let args = call.arguments else {
                return
            }
            // Get the arguments
            if let arguments = args as? [String: Any],
            let movieURL = arguments["movieUrl"] as? String,
            let subtitlesURL = arguments["subtitlesUrl"]  as? String {
                // Launch the player with the provided urls
                self.launchMoviePlayer(movieURLString: movieURL,
                                       subtitlesURLString: subtitlesURL)
            }
        }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func launchMoviePlayer(movieURLString: String, subtitlesURLString: String) {
        let videoURL = URL(string: movieURLString)!
        
        // Movie player
        let moviePlayer = AVPlayerViewController()
        moviePlayer.player = AVPlayer(url: videoURL)
        window?.rootViewController?.present(moviePlayer, animated: true, completion: nil)
        
        // Add subtitles
        if let subtitlesURL = URL(string: subtitlesURLString) {
             moviePlayer.addSubtitles().open(fileFromRemote: subtitlesURL, encoding: String.Encoding.utf8)
        }
        
        // Change text properties
        //        moviePlayer.subtitleLabel?.textColor = UIColor.red
        
        // Play
        moviePlayer.player?.play()
    }
}
