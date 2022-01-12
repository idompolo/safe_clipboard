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

  test('SafeClipboard.get', () async {
    expect(await SafeClipboard.get(), '42');
  });
}
