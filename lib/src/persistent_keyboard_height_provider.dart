import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';

import 'persistent_keyboard_height.dart';
import 'shared_preferences_persistent_keyboard_height_storage_provider.dart';

class PersistentKeyboardHeightProvider extends StatefulWidget {
  const PersistentKeyboardHeightProvider({
    required this.child,
    this.storageProvider =
        const SharedPreferencesPersistentKeyboardSizeStorageProvider(),
    Key? key,
  }) : super(key: key);

  final Widget child;
  final IPersistentKeyboardHeightStorageProvider storageProvider;

  @override
  _PersistentKeyboardHeightProviderState createState() =>
      _PersistentKeyboardHeightProviderState();
}

class _PersistentKeyboardHeightProviderState
    extends State<PersistentKeyboardHeightProvider> {
  final KeyboardUtils _keyboardUtils = KeyboardUtils();

  /// The ID we get when adding a listener to [_keyboardUtils] via
  /// [KeyboardUtils.add]. Used in [dispose] to remove the listener.
  int? _keyboardUtilsListenerId;

  /// The value that we get from [KeyboardListener.willShowKeyboard].
  double _keyboardHeightFromKeyboardUtils = 0.0;

  /// Exposed via [PersistentKeyboardHeight.keyboardHeight].
  double _keyboardHeight = 0.0;

  /// Used in [_onWillShowKeyboard] for calling [_maybeSetKeyboardHeight].
  double _bottomOffset = 0.0;

  @override
  void initState() {
    super.initState();

    widget.storageProvider.getHeight().then((value) {
      if (value > 0 && _keyboardHeight < 1) {
        _keyboardHeight = value;
        if (mounted) setState(() {});
      }
    });

    _keyboardUtilsListenerId = _keyboardUtils.add(
      listener: KeyboardListener(willShowKeyboard: _onWillShowKeyboard),
    );
  }

  @override
  void dispose() {
    _keyboardUtils.unsubscribeListener(subscribingId: _keyboardUtilsListenerId);
    if (_keyboardUtils.canCallDispose()) {
      _keyboardUtils.dispose();
    }
    super.dispose();
  }

  /// The callback that is passed to [KeyboardListener] on [KeyboardUtils.add].
  void _onWillShowKeyboard(double height) {
    _keyboardHeightFromKeyboardUtils = height;

    if (_keyboardHeight > height) {
      _maybeSetKeyboardHeight(
        bottomOffset: _bottomOffset,
        keyboardHeightFromKeyboardUtils: height,
      );
    }
  }

  /// Checks whether or not keyboard height should be updated  and
  /// if so, updates the inherited widget and saves the height
  /// via [widget.storageProvider].
  void _maybeSetKeyboardHeight({
    required double bottomOffset,
    required double keyboardHeightFromKeyboardUtils,
  }) async {
    if (bottomOffset >= keyboardHeightFromKeyboardUtils) {
      _keyboardHeight = bottomOffset;

      /// Perhaps [mounted] will always be [true] when this code is reached
      /// but let's be safe :).
      if (mounted) setState(() {});

      await widget.storageProvider.setHeight(bottomOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/a/49271649/9714875
    _bottomOffset = MediaQuery.of(context).viewInsets.bottom;

    if (_keyboardHeightFromKeyboardUtils != 0 &&
        _bottomOffset != _keyboardHeight) {
      _maybeSetKeyboardHeight(
        bottomOffset: _bottomOffset,
        keyboardHeightFromKeyboardUtils: _keyboardHeightFromKeyboardUtils,
      );
    }

    return PersistentKeyboardHeight(
      keyboardHeight: _keyboardHeight,
      child: widget.child,
    );
  }
}
