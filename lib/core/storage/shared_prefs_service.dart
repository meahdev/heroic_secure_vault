import 'package:shared_preferences/shared_preferences.dart';

/// A singleton wrapper around SharedPreferences for easier and centralized usage.
///
/// This service is used to store non-sensitive app preferences such as:
/// - Flags to detect fresh installs (e.g., "is_first_install")
///   This is important because on iOS, secure data stored in the Keychain
///   (via SecureStorageService) persists after uninstall, so
///   SharedPreferences acts as the indicator of a fresh install.
///
/// - Theme preferences (e.g., light or dark mode selection)
///   These are simple app settings that don't require secure storage.
///
/// For storing sensitive data such as authentication tokens, PINs, or other secrets,
/// use SecureStorageService which wraps FlutterSecureStorage.
class SharedPrefsService {
  /// Singleton instance of the service
  static final SharedPrefsService _instance = SharedPrefsService._internal();

  /// Factory constructor to return the same singleton instance
  factory SharedPrefsService() => _instance;

  SharedPreferences? _prefs;

  /// Private internal constructor
  SharedPrefsService._internal();

  /// Initializes the SharedPreferences instance if not already initialized.
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ---------------------------
  // Getters for primitive types
  // ---------------------------

  /// Retrieves a String value for the given [key], or null if not found.
  String? getString(String key) => _prefs?.getString(key);

  /// Retrieves a bool value for the given [key], or null if not found.
  bool? getBool(String key) => _prefs?.getBool(key);

  /// Retrieves an int value for the given [key], or null if not found.
  int? getInt(String key) => _prefs?.getInt(key);

  // ---------------------------
  // Setters for primitive types
  // ---------------------------

  /// Sets a boolean [value] for the given [key].
  Future<void> setBool(String key, bool value) async =>
      await _prefs?.setBool(key, value);

  /// Sets a String [value] for the given [key].
  Future<void> setString(String key, String value) async =>
      await _prefs?.setString(key, value);

  // ---------------------------
  // Clear all preferences
  // ---------------------------

  /// Clears all stored preferences.
  Future<void> clear() async => await _prefs?.clear();
}
