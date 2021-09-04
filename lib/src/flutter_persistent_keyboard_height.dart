import 'package:flutter/material.dart';

class FlutterPersistentKeyboardHeight extends InheritedWidget {
  const FlutterPersistentKeyboardHeight({
    required Widget child,
    required this.keyboardHeight,
    Key? key,
  }) : super(child: child, key: key);

  final double keyboardHeight;

  static FlutterPersistentKeyboardHeight of(BuildContext context) {
    final FlutterPersistentKeyboardHeight? result = context
        .dependOnInheritedWidgetOfExactType<FlutterPersistentKeyboardHeight>();
    assert(
      result != null,
      'No FlutterPersistentKeyboardHeight found in current widget tree.',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(FlutterPersistentKeyboardHeight oldWidget) {
    return keyboardHeight != oldWidget.keyboardHeight;
  }
}
