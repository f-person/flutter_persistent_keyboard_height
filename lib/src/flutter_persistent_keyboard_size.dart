import 'package:flutter/material.dart';

class FlutterPersistentKeyboardSize extends InheritedWidget {
  const FlutterPersistentKeyboardSize({
    required Widget child,
    required this.keyboardHeight,
    Key? key,
  }) : super(child: child, key: key);

  final double keyboardHeight;

  static FlutterPersistentKeyboardSize of(BuildContext context) {
    final FlutterPersistentKeyboardSize? result = context
        .dependOnInheritedWidgetOfExactType<FlutterPersistentKeyboardSize>();
    assert(
      result != null,
      'No FlutterPersistentKeyboardSize found in current widget tree.',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(FlutterPersistentKeyboardSize oldWidget) {
    return keyboardHeight != oldWidget.keyboardHeight;
  }
}
