import Flutter
import UIKit

public class SwiftSafeClipboardPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "safe_clipboard", binaryMessenger: registrar.messenger())
        let instance = SwiftSafeClipboardPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getClipboardTextSafe":
            getClipboardSafe(call: call, flutterResult: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func getClipboardSafe(call: FlutterMethodCall, flutterResult: @escaping FlutterResult) {
        if #available(iOS 14.0, *) {
            
            // We are only interested in strings
            if !UIPasteboard.general.hasStrings { flutterResult(nil) }
            
            
            if let detection = getDetectionPatternFromArgs(call: call) {
                UIPasteboard.general.detectPatterns(for: [detection], completionHandler: { result in
                    
                    switch result {
                    case .success(let detectedPatterns):
                        // A pattern detection is completed,
                        // regardless of whether the pasteboard has patterns we care about.
                        // So we have to check if the detected patterns contains our pattern.
                        
                        if detectedPatterns.contains(detection) {
                            flutterResult(UIPasteboard.general.string)
                        } else {
                            // We won't be retrieving the value, so we won't get a notification banner
                            flutterResult(nil)
                        }
                    case .failure(_):
                        // Handle a filure
                        flutterResult(nil)
                    }
                    
                })
            } else {
                flutterResult(UIPasteboard.general.string)
            }
        } else {
            flutterResult(UIPasteboard.general.string)
        }
    }
    
    @available(iOS 14.0, *)
    func getDetectionPatternFromArgs(call: FlutterMethodCall) -> UIPasteboard.DetectionPattern? {
        if let args = call.arguments as? Dictionary<String, Any>,
           let iOSDetectionPattern = args["iOSDetectionPattern"] as? String? {
            switch iOSDetectionPattern {
            case "probableWebURL":
                return UIPasteboard.DetectionPattern.probableWebURL
            case "probableWebSearch":
                return UIPasteboard.DetectionPattern.probableWebSearch
            case "number":
                return UIPasteboard.DetectionPattern.number
            case .none:
                return nil;
            case .some(_):
                return nil;
            }
        }
        return nil
    }
}
