import '../storage/app_storage.dart';

/// A simple manager for handling authentication tokens.
class TokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  /// Retrieves the access token from storage.
  static Future<String?> get access async {
    return AppStorage.getString(_accessTokenKey);
  }

  /// Retrieves the refresh token from storage.
  static Future<String?> get refresh async {
    return AppStorage.getString(_refreshTokenKey);
  }

  /// Saves both access and refresh tokens to storage.
  static Future<void> saveTokens({required String access, String? refresh}) async {
    await AppStorage.saveString(_accessTokenKey, access);
    if (refresh != null) {
      await AppStorage.saveString(_refreshTokenKey, refresh);
    }
  }

  /// Clears all tokens from storage.
  static Future<void> clear() async {
    await AppStorage.remove(_accessTokenKey);
    await AppStorage.remove(_refreshTokenKey);
  }
}
