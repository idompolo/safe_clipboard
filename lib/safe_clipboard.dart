import 'dart:async';

import 'package:flutter/services.dart';

class SafeClipboard {
  static const MethodChannel _channel = MethodChannel('safe_clipboard');

  static Future<String?> get({iOSDetectionPattern? iOSDetectionPattern}) async {
    final String? version = await _channel.invokeMethod(
      'getClipboardTextSafe',
      {
        'iOSDetectionPattern': iOSDetectionPattern?.name,
      },
    );
    return version;
  }
}

enum iOSDetectionPattern { probableWebURL, probableWebSearch, number }
