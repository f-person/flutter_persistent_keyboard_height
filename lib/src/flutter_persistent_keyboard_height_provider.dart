import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';

import 'flutter_persistent_keyboard_height.dart';
import 'shared_preferences_persistent_keyboard_height_storage_provider.dart';

class FlutterPersistentKeyboardHeightProvider extends StatefulWidget {
  const FlutterPersistentKeyboardHeightProvider({
    required this.child,
    this.storageProvider =
        const SharedPreferencesPersistentKeyboardSizeStorageProvider(),
    Key? key,
  }) : super(key: key);

  final Widget child;
  final IPersistentKeyboardHeightStorageProvider storageProvider;

  @override
  _FlutterPersistentKeyboardHeightProviderState createState() =>
      _FlutterPersistentKeyboardHeightProviderState();
}

class _FlutterPersistentKeyboardHeightProviderState
    extends State<FlutterPersistentKeyboardHeightProvider> {
  double _keyboardHeight = 0.0;

  @override
  void initState() {
    super.initState();

    widget.storageProvider.getHeight().then((value) {
      if (value > 0 && _keyboardHeight < 1) {
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

    return FlutterPersistentKeyboardHeight(
      keyboardHeight: _keyboardHeight,
      child: widget.child,
    );
  }
}
