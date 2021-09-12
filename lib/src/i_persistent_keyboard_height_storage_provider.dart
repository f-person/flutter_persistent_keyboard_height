import 'package:flutter_persistent_keyboard_height/src/shared_preferences_persistent_keyboard_height_storage_provider.dart';

/// An interface for preserving the height of the keyboard.
/// The default implementation is [SharedPreferencesPersistentKeyboardSizeStorageProvider].
///
/// In order to implement your own storage for create a class that implements
/// this class and override [setHeight] and [getHeight].
///
/// Example:
/// ```dart
/// class CustomPersistentKeyboardHeightStorageProvider
///     implements IPersistentKeyboardHeightStorageProvider {
///   @override
///   Future<double> getHeight() {
///     // read the height from storage
///   }
///
///   @override
///   Future<void> setHeight(double height) {
///     // save the height to storage
///   }
/// }
/// ```
abstract class IPersistentKeyboardHeightStorageProvider {
  /// Save the height to storage.
  Future<void> setHeight(double height);

  /// Get the height from storage.
  Future<double> getHeight();
}
