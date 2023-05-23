import Flutter
import UIKit

public class VtblePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    SwiftBlePlugin.register(with: registrar)
  }
}
