import 'package:flutter/material.dart';

import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Persistent Keyboard Height Example',
      home: FlutterPersistentKeyboardHeightProvider(
        child: FlutterPersistentKeyboardHeightExample(),
      ),
    );
  }
}

class FlutterPersistentKeyboardHeightExample extends StatelessWidget {
  const FlutterPersistentKeyboardHeightExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyboardHeight =
        FlutterPersistentKeyboardHeight.of(context).keyboardHeight;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Flutter Persistent Keyboard Size Example',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(keyboardHeight.toString()),
        ],
      ),
    );
  }
}
