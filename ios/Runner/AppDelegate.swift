import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyCFBfcNHFg97sM7EhKnAP4OHIoY3Q8Y_xQ")
    GeneratedPluginRegistrant.register(with: self)
    if let controller = window?.rootViewController as? FlutterViewController {
      let factory = NativeTurnByTurnNavFactory(messenger: controller.binaryMessenger)
      registrar(forPlugin: "NativeTurnByTurnNav")?.register(factory, withId: "NativeTurnByTurnNav")
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
