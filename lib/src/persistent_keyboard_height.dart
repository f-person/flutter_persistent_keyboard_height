import 'package:flutter/material.dart';

/// The inherited widget for getting the keyboard height.
///
/// Getting the current keyboard height is as follows:
/// ```dart
/// PersistentKeyboardHeight.of(context).keyboardHeight
/// ```
class PersistentKeyboardHeight extends InheritedWidget {
  const PersistentKeyboardHeight({
    required Widget child,
    required this.keyboardHeight,
    Key? key,
  }) : super(child: child, key: key);

  /// The current height of the keyboard.
  final double keyboardHeight;

  /// Typical usage is as follows:
  /// ```dart
  /// final keyboardHeight = PersistentKeyboardHeight.of(context).keyboardHeight;
  /// ```
  static PersistentKeyboardHeight of(BuildContext context) {
    final PersistentKeyboardHeight? result =
        context.dependOnInheritedWidgetOfExactType<PersistentKeyboardHeight>();
    assert(
      result != null,
      'No PersistentKeyboardHeight found in current widget tree.',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(PersistentKeyboardHeight oldWidget) {
    return keyboardHeight != oldWidget.keyboardHeight;
  }
}
