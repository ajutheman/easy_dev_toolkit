import 'package:shared_preferences/shared_preferences.dart';

/// A wrapper around [SharedPreferences] for easy and consistent local storage.
class AppStorage {
  static SharedPreferences? _prefs;

  /// Initializes the [SharedPreferences] instance.
  /// Should be called in `main()` before using any other methods.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Saves a [String] value to storage.
  static Future<bool> saveString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Alias for [saveString] or other type-specific savers.
  static Future<void> write(String key, dynamic value) async {
    if (value is String) await saveString(key, value);
    if (value is bool) await saveBool(key, value);
    if (value is int) await saveInt(key, value);
  }

  /// Retrieves a value from storage.
  static T? read<T>(String key) {
    if (T == String) return _prefs?.getString(key) as T?;
    if (T == bool) return _prefs?.getBool(key) as T?;
    if (T == int) return _prefs?.getInt(key) as T?;
    return null;
  }

  /// Retrieves a [String] value from storage.
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Saves a [bool] value to storage.
  static Future<bool> saveBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// Retrieves a [bool] value from storage.
  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  /// Saves an [int] value to storage.
  static Future<bool> saveInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  /// Retrieves an [int] value from storage.
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Checks if a key exists in storage.
  static bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  /// Removes a value from storage.
  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Clears all values from storage.
  static Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }
}
