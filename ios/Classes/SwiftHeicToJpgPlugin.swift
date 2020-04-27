import Flutter
import UIKit

public class SwiftHeicToJpgPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "heic_to_jpg", binaryMessenger: registrar.messenger())
    let instance = SwiftHeicToJpgPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "convert" {
        guard
            let heicPath = call.arguments as? String,
            let heicImage = UIImage(named: heicPath),
            let jpgImageData = heicImage.jpegData(compressionQuality: 0.7),
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        else {
            result(nil)
            return
        }
      
        let fileName = ((heicPath as NSString).lastPathComponent as NSString).deletingPathExtension
        let jpgPath = (docDir as NSString).appendingPathComponent(fileName + ".jpeg")
        
        if FileManager.default.createFile(atPath: jpgPath, contents: jpgImageData, attributes: nil) {
            result(jpgPath)
        }
        else {
            result(nil)
        }
    }
    else {
        result(FlutterMethodNotImplemented)
    }
  }
}
