import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_clipboard/safe_clipboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditingController = TextEditingController();
  String _lastValue = 'None';

  Future<void> getClipboard({iOSDetectionPattern? iOSDetectionPattern}) async {
    String clipboardValue;
    try {
      clipboardValue = await SafeClipboard.get(
            iOSDetectionPattern: iOSDetectionPattern,
          ) ??
          'Null response';
    } on PlatformException {
      clipboardValue = 'Failed to get clipboard data';
    }

    if (!mounted) return;

    setState(() {
      _lastValue = clipboardValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SafeClipboard Example App'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text('Last read value: $_lastValue'),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Get Clipboard'),
                  onPressed: () {
                    getClipboard();
                  },
                ),
                ElevatedButton(
                  child: Text(
                      'Get Clipboard with ${iOSDetectionPattern.probableWebURL.name}'),
                  onPressed: () {
                    getClipboard(
                      iOSDetectionPattern: iOSDetectionPattern.probableWebURL,
                    );
                  },
                ),
                ElevatedButton(
                  child: Text(
                      'Get Clipboard with ${iOSDetectionPattern.probableWebSearch.name}'),
                  onPressed: () {
                    getClipboard(
                      iOSDetectionPattern:
                          iOSDetectionPattern.probableWebSearch,
                    );
                  },
                ),
                ElevatedButton(
                  child: Text(
                      'Get Clipboard with ${iOSDetectionPattern.number.name}'),
                  onPressed: () {
                    getClipboard(
                      iOSDetectionPattern: iOSDetectionPattern.number,
                    );
                  },
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  child: const Text('Set Clipboard to https://www.google.com/'),
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: 'https://www.google.com/'));
                  },
                ),
                ElevatedButton(
                  child: const Text('Set Clipboard to cheap flights'),
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: 'cheap flights'));
                  },
                ),
                ElevatedButton(
                  child: const Text('Set Clipboard to 42'),
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: '42'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
