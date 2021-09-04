import 'package:shared_preferences/shared_preferences.dart';

import 'i_persistent_keyboard_size_storage_provider.dart';

class SharedPreferencesPersistentKeyboardSizeStorageProvider
    implements IPersistentKeyboardSizeStorageProvider {
  const SharedPreferencesPersistentKeyboardSizeStorageProvider();

  static const _heightKey = 'persistent_keyboard_size.height';

  @override
  Future<double> getHeight() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_heightKey) ?? 0.0;
  }

  @override
  Future<void> setHeight(double height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_heightKey, height);
  }
}
