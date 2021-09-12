import 'package:flutter/material.dart';

/// The inherited widget for getting the keyboard height.
///
/// Getting the current keyboard height is as follows:
/// ```dart
/// FlutterPersistentKeyboardHeight.of(context).keyboardHeight
/// ```
class FlutterPersistentKeyboardHeight extends InheritedWidget {
  const FlutterPersistentKeyboardHeight({
    required Widget child,
    required this.keyboardHeight,
    Key? key,
  }) : super(child: child, key: key);

  /// The current height of the keyboard.
  final double keyboardHeight;

  /// Typical usage is as follows:
  /// ```dart
  /// final double keyboardHeight = FlutterPersistentKeyboardHeight.of(context).keyboardHeight;
  /// ```
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
