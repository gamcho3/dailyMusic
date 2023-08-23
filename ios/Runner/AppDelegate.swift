import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var sharedUrl: String?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: "SHARE_URL",
                                                    binaryMessenger: controller.binaryMessenger)
      channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if call.method == "getYoutubeUrl" {
              result(self.sharedUrl)
          }
          
          })
   
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        sharedUrl = url.absoluteString
        return true
      }
}
