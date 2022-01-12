import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

bool get _isiOS => defaultTargetPlatform == TargetPlatform.iOS;

class SafeClipboard {
  static const MethodChannel _channel = MethodChannel('safe_clipboard');

  /// Gets the current clipboard text data.
  ///
  /// On iOS you can pass in a specific [iOSDetectionPattern] to avoid accessing
  /// the clipboard if the current clipboard data is not relevent to your app.
  ///
  /// This is used to avoid the system notification for clipboard access. Read
  /// more about this at the link below.
  ///
  /// https://developer.apple.com/documentation/uikit/uipasteboard
  static Future<String?> get({iOSDetectionPattern? iOSDetectionPattern}) async {
    if (!_isiOS) {
      final clipData = await Clipboard.getData('text/plain');
      return clipData?.text;
    }
    final String? value = await _channel.invokeMethod(
      'getClipboardTextSafe',
      {
        'iOSDetectionPattern': iOSDetectionPattern?.name,
      },
    );
    return value;
  }
}

enum iOSDetectionPattern { probableWebURL, probableWebSearch, number }
