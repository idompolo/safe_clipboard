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

/// Gets the current clipboard text data.
///
/// On iOS you can pass in a specific [iOSDetectionPattern] to avoid accessing
/// the clipboard if the current clipboard data is not relevent to your app.
///
/// This is used to avoid the system notification for clipboard access. Read
/// more about this at the link below.
///
/// https://developer.apple.com/documentation/uikit/uipasteboard
var clipboard = await SafeClipboard.get(
    iOSDetectionPattern: iOSDetectionPattern.probableWebURL,
);
```

