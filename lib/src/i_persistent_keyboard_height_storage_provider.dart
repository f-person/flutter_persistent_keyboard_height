abstract class IPersistentKeyboardHeightStorageProvider {
  Future<void> setHeight(double height);

  Future<double> getHeight();
}
