# Safe Clipboard

For most common use cases you can use the [Clipboard class](https://api.flutter.dev/flutter/services/Clipboard-class.html) built into Flutter.

## Purpose

In iOS 14+ when an app reads the clipboard the system will [notify the user](https://developer.apple.com/documentation/uikit/uipasteboard). 

In Android 12+ when an app reads the clipboard the system will [notify the user](https://developer.android.com/about/versions/12/behavior-changes-all#clipboard-access-notifications). 

Some applications check the clipboard on app start or resume from background to do some special action. This can cause a notification every time your app is opened.

Safe Clipboard exposes the ability to only read from the clipboard when the clipboard matches a built in pattern. This can help avoid notification spam.

## Getting Started

```dart
import 'package:safe_clipboard/safe_clipboard.dart';

/// Here a common example of only accessing the clipboard when the clipboard
/// is likely to be a URL. This is often used to check if the URL is a 
/// deep link to your app. iOS can speficifally check for a URL, while on
/// Android the closest thing is checking for plain text.
///
/// If the current clipboard data doesn't match the pattern, null is returned.
var clipboard = await SafeClipboard.get(
    iOSDetectionPattern: iOSDetectionPattern.probableWebURL,
    androidClipMimeType: AndroidClipMimeType.textPlain,
);
```

