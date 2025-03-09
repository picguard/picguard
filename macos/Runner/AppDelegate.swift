import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    if let window = mainFlutterWindow {
      let controller = window.contentViewController as! FlutterViewController
      let macosMenuChannel = FlutterMethodChannel(name: "macos_menu_channel", binaryMessenger: controller.engine.binaryMessenger)

      macosMenuChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        if call.method == "hideApp" {
          // Hide the "About" window
          NSApp.hide(nil)
          result(nil)
        } else if call.method == "hideOtherApps" {
          // Hide other windows
          NSApp.hideOtherApplications(nil)
          result(nil)
        } else if call.method == "showAllApps" {
          // Show all windows
          NSApp.unhideAllApplications(nil)
          result(nil)
        } else if call.method == "showAboutPanel" {
          // Show the "About" window
          NSApp.orderFrontStandardAboutPanel(options: [:])
          result(nil)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    } else {
      print("mainFlutterWindow is nil")
    }

    super.applicationDidFinishLaunching(aNotification)
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
