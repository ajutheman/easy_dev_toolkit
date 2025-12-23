import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// A simple cache manager for storing JSON data with TTL (Time To Live).
class CacheManager {
  static SharedPreferences? _prefs;

  static Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Retrieves cached JSON data if it's not expired.
  static Future<dynamic> getJson(String key) async {
    await _init();
    final String? cachedData = _prefs?.getString('cache_$key');
    if (cachedData == null) return null;

    final Map<String, dynamic> data = json.decode(cachedData);
    final int expiry = data['expiry'] ?? 0;
    
    if (DateTime.now().millisecondsSinceEpoch > expiry) {
      await _prefs?.remove('cache_$key');
      return null;
    }

    return data['content'];
  }

  /// Stores JSON data with a specified TTL.
  static Future<void> putJson(String key, dynamic data, {Duration ttl = const Duration(minutes: 10)}) async {
    await _init();
    final Map<String, dynamic> cacheWrapper = {
      'expiry': DateTime.now().add(ttl).millisecondsSinceEpoch,
      'content': data,
    };
    await _prefs?.setString('cache_$key', json.encode(cacheWrapper));
  }

  /// Clears a specific cache entry.
  static Future<void> remove(String key) async {
    await _init();
    await _prefs?.remove('cache_$key');
  }

  /// Clears all cache entries.
  static Future<void> clear() async {
    await _init();
    final keys = _prefs?.getKeys() ?? <String>{};
    for (final String key in keys) {
      if (key.startsWith('cache_')) {
        await _prefs?.remove(key);
      }
    }
  }
}
