import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_size/flutter_persistent_keyboard_size.dart';

import 'flutter_persistent_keyboard_size.dart';
import 'shared_preferences_persistent_keyboard_size_storage_provider.dart';

class FlutterPersistentKeyboardSizeProvider extends StatefulWidget {
  const FlutterPersistentKeyboardSizeProvider({
    required this.child,
    this.storageProvider =
        const SharedPreferencesPersistentKeyboardSizeStorageProvider(),
    Key? key,
  }) : super(key: key);

  final Widget child;
  final IPersistentKeyboardSizeStorageProvider storageProvider;

  @override
  _FlutterPersistentKeyboardSizeProviderState createState() =>
      _FlutterPersistentKeyboardSizeProviderState();
}

class _FlutterPersistentKeyboardSizeProviderState
    extends State<FlutterPersistentKeyboardSizeProvider> {
  double _keyboardHeight = 0.0;

  @override
  void initState() {
    super.initState();

    widget.storageProvider.getHeight().then((value) {
      if (value > 0 && _keyboardHeight > 0) {
        _keyboardHeight = value;
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/a/49271649/9714875
    final bottomOffset = MediaQuery.of(context).viewInsets.bottom;
    if (bottomOffset > 0) {
      if (_keyboardHeight != bottomOffset) {
        widget.storageProvider.setHeight(bottomOffset);
      }

      _keyboardHeight = bottomOffset;
    }

    return FlutterPersistentKeyboardSize(
      keyboardHeight: _keyboardHeight,
      child: widget.child,
    );
  }
}
