import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_clipboard/safe_clipboard.dart';

void main() {
  const MethodChannel channel = MethodChannel('safe_clipboard');

  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
    SystemChannels.platform
        .setMockMethodCallHandler((MethodCall methodCall) async {
      return {
        'text': '24',
      };
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  testWidgets('SafeClipboard.get on iOS returns platform result',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp());
    expect(await SafeClipboard.get(), '42');
  }, variant: TargetPlatformVariant.only(TargetPlatform.iOS));

  testWidgets('SafeClipboard.get on Android uses SystemChannels',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp());
    expect(await SafeClipboard.get(), '24');
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));
}
