import UIKit
import Flutter
import LocalAuthentication

@main
@objc class AppDelegate: FlutterAppDelegate {

  private let channelName = "native_auth"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: channelName,
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { call, result in
      if call.method == "authenticate" {
        self.authenticate(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func authenticate(result: @escaping FlutterResult) {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
      context.evaluatePolicy(
        .deviceOwnerAuthentication,
        localizedReason: "Authenticate to continue"
      ) { success, _ in
        DispatchQueue.main.async {
          result(success)
        }
      }
    } else {
      result(false)
    }
  }
}
