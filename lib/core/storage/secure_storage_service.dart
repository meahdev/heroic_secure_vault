import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// A singleton service that provides secure key-value storage using [FlutterSecureStorage].
///
/// This service is responsible for securely storing sensitive data like authentication tokens and PINs.
/// It also detects a fresh install and clears any old Keychain data that might persist after uninstall.
class SecureStorageService {
  // Singleton instance of the service
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  // FlutterSecureStorage instance with iOS-specific options
  // 'first_unlock_this_device_only' ensures data is tied to the device and not backed up
  final FlutterSecureStorage _storage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.unlocked_this_device,
    ),
  );

  // Factory constructor to return the singleton instance
  factory SecureStorageService() => _instance;

  // Private internal constructor
  SecureStorageService._internal();

  /// Clears all secure storage values on iOS if this is the first install.
  ///
  /// iOS Keychain persists even after app uninstall. This method detects a fresh install
  /// by checking SharedPreferences (which is cleared on uninstall) and clears the Keychain
  /// to prevent leftover secure data from being reused.
  Future<void> clearAllIfFirstInstall() async {
    final prefs = await SharedPreferences.getInstance();

    // Check SharedPreferences for a flag indicating previous install
    final isFirstInstall = prefs.getBool('is_first_install') ?? true;

    if (isFirstInstall) {
      // If it's the first install (or reinstall), clear all secure storage
      await _storage.deleteAll();

      // Set the flag to false to avoid clearing next time
      await prefs.setBool('is_first_install', false);
    }
  }

  /// Writes a value to secure storage for the given [key].
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads the value associated with the given [key] from secure storage.
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  /// Deletes the value associated with the given [key] from secure storage.
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Checks whether the given [key] exists in secure storage.
  Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }
}
