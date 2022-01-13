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
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  testWidgets('SafeClipboard.get returns platform result',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp());
    expect(await SafeClipboard.get(), '42');
  });
}
