
import 'package:shared_preferences/shared_preferences.dart';

/// A singleton wrapper around SharedPreferences for easier and centralized usage.
class SharedPrefsService {
  // The singleton instance
  static final SharedPrefsService _instance = SharedPrefsService._internal();

  // Factory constructor to return the same instance
  factory SharedPrefsService() => _instance;

  SharedPreferences? _prefs;

  SharedPrefsService._internal();

  /// Initializes the shared preferences instance if not already initialized.
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ---------------------------
  // Getters
  // ---------------------------

  String? getString(String key) => _prefs?.getString(key);
  bool? getBool(String key) => _prefs?.getBool(key);
  int? getInt(String key) => _prefs?.getInt(key);

  // ---------------------------
  // Setters
  // ---------------------------

  Future<void> setBool(String key, bool value) async =>
      await _prefs?.setBool(key, value);

  Future<void> setString(String key, String value) async =>
      await _prefs?.setString(key, value);

  // ---------------------------
  // Clear all preferences
  // ---------------------------

  Future<void> clear() async => await _prefs?.clear();
}
