import 'dart:async';

import 'package:flutter/services.dart';

class SafeClipboard {
  static const MethodChannel _channel = MethodChannel('safe_clipboard');

  /// Gets the current clipboard text data.
  ///
  /// On iOS you can pass in a specific [iOSDetectionPattern] to avoid accessing
  /// the clipboard if the current clipboard data is not relevant to your app.
  ///
  /// On Android you can pass in a specific [AndroidClipMimeType] to avoid accessing
  /// the clipboard if the current clipboard data is not relevant to your app.
  ///
  /// This is used to avoid the system notification for clipboard access. Read
  /// more about this at the links below.
  ///
  /// https://developer.apple.com/documentation/uikit/uipasteboard
  /// https://developer.android.com/about/versions/12/behavior-changes-all#clipboard-access-notifications
  static Future<String?> get({
    iOSDetectionPattern? iOSDetectionPattern,
    AndroidClipMimeType? androidClipMimeType,
  }) async {
    final String? value = await _channel.invokeMethod(
      'getClipboardTextSafe',
      {
        'iOSDetectionPattern': iOSDetectionPattern?.toString().split('.').last,
        'AndroidClipMimeType': androidClipMimeType?.toString().split('.').last,
      },
    );
    return value;
  }
}

enum iOSDetectionPattern {
  /// https://developer.apple.com/documentation/uikit/uipasteboard/detectionpattern/3618951-probableweburl
  probableWebURL,

  /// https://developer.apple.com/documentation/uikit/uipasteboard/detectionpattern/3618950-probablewebsearch
  probableWebSearch,

  /// https://developer.apple.com/documentation/uikit/uipasteboard/detectionpattern/3650233-number
  number,
}

enum AndroidClipMimeType {
  /// https://developer.android.com/reference/android/content/ClipDescription#MIMETYPE_TEXT_HTML
  textHtml,

  /// https://developer.android.com/reference/android/content/ClipDescription#MIMETYPE_TEXT_INTENT
  textPlain,

  /// https://developer.android.com/reference/android/content/ClipDescription#MIMETYPE_TEXT_INTENT
  intent,

  /// https://developer.android.com/reference/android/content/ClipDescription#MIMETYPE_TEXT_URILIST
  uriList,

  /// https://developer.android.com/reference/android/content/ClipDescription#MIMETYPE_UNKNOWN
  unknown,
}
