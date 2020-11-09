import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    var keys: NSDictionary?

    if let path = Bundle.main.path(forResource: "google_maps_api", ofType: "plist") {
        keys = NSDictionary(contentsOfFile: path)
    }

    var googleApiKey: String?

   if let dict = keys {
     googleApiKey = dict["google_maps_key"] as? String
   }
    GMSServices.provideAPIKey(googleApiKey!)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
