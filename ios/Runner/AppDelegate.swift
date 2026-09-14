import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private let storyChannelName = "charlizard/story_share"
  private var storyChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    // The view hierarchy may not exist yet; defer and retry on activation.
    DispatchQueue.main.async { [weak self] in
      self?.registerStoryChannel()
    }
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    registerStoryChannel()
  }

  /// Attaches the story-share channel once the FlutterViewController exists.
  /// Safe to call repeatedly; no-ops after the first successful attach.
  private func registerStoryChannel() {
    guard storyChannel == nil else { return }
    let windows = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
    guard let controller = windows.first?.rootViewController as? FlutterViewController else {
      return
    }
    let channel = FlutterMethodChannel(
      name: storyChannelName,
      binaryMessenger: controller.binaryMessenger
    )
    channel.setMethodCallHandler { [weak self] call, result in
      switch call.method {
      case "isAppInstalled":
        let scheme = (call.arguments as? [String: Any])?["package"] as? String ?? ""
        // On iOS the Dart side passes a package id; map to URL schemes.
        let urlScheme: String?
        if scheme == "com.instagram.android" {
          urlScheme = "instagram-stories://"
        } else if scheme == "com.facebook.katana" {
          urlScheme = "facebook-stories://"
        } else {
          urlScheme = nil
        }
        if let urlScheme, let url = URL(string: urlScheme) {
          result(UIApplication.shared.canOpenURL(url))
        } else {
          result(false)
        }
      case "shareToInstagramStory":
        let args = call.arguments as? [String: Any]
        let path = args?["filePath"] as? String ?? ""
        let appId = args?["applicationId"] as? String ?? ""
        result(self?.shareToStory(
          scheme: "instagram-stories://share?source_application=\(appId)",
          pasteboardName: "com.instagram.sharedSticker",
          stickerKey: "com.instagram.sharedSticker.backgroundImage",
          filePath: path
        ) ?? false)
      case "shareToFacebookStory":
        let args = call.arguments as? [String: Any]
        let path = args?["filePath"] as? String ?? ""
        let appId = args?["applicationId"] as? String ?? ""
        result(self?.shareToStory(
          scheme: "facebook-stories://share?source_application=\(appId)",
          pasteboardName: "com.facebook.sharedSticker",
          stickerKey: "com.facebook.sharedSticker.backgroundImage",
          filePath: path
        ) ?? false)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    storyChannel = channel
  }

  /// Shares a background image to Instagram/Facebook Stories via the
  /// officially documented pasteboard + URL-scheme flow. Returns false when
  /// the target app is unavailable so Dart can fall back to the share sheet.
  private func shareToStory(
    scheme: String,
    pasteboardName: String,
    stickerKey: String,
    filePath: String
  ) -> Bool {
    guard let url = URL(string: scheme),
          UIApplication.shared.canOpenURL(url) else {
      return false
    }
    guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
          let image = UIImage(data: imageData),
          let png = image.pngData() else {
      return false
    }
    let pasteboardOptions: [UIPasteboard.OptionsKey: Any] = [
      .expirationDate: Date().addingTimeInterval(300)
    ]
    UIPasteboard(name: UIPasteboard.Name(rawValue: pasteboardName), create: true)?
      .setItems([[stickerKey: png]], options: pasteboardOptions)
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
    return true
  }
}
