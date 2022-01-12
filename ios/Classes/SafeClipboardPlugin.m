#import "SafeClipboardPlugin.h"
#if __has_include(<safe_clipboard/safe_clipboard-Swift.h>)
#import <safe_clipboard/safe_clipboard-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "safe_clipboard-Swift.h"
#endif

@implementation SafeClipboardPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSafeClipboardPlugin registerWithRegistrar:registrar];
}
@end
