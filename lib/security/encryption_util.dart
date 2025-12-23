import 'dart:convert';
import 'package:encrypt/encrypt.dart';

/// A utility class for AES-256 encryption and decryption.
class EncryptionUtil {
  /// The encryption key (must be 32 bytes for AES-256).
  final Key key;

  /// The initialization vector (must be 16 bytes).
  final IV iv;

  /// Creates an [EncryptionUtil] with the provided base64 encoded key and IV.
  EncryptionUtil(String base64Key, String base64Iv)
      : key = Key.fromBase64(base64Key),
        iv = IV.fromBase64(base64Iv);

  /// Encrypts a JSON-serializable object.
  String encryptJson(dynamic obj) {
    try {
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final plain = jsonEncode(obj);
      final encrypted = encrypter.encrypt(plain, iv: iv);
      return encrypted.base64;
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }

  /// Decrypts a base64 string back to a JSON object.
  dynamic decryptToJson(String base64) {
    try {
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(base64, iv: iv);
      return jsonDecode(decrypted);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }

  /// Encrypts a simple string.
  String encryptString(String plainText) {
    try {
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (e) {
      throw Exception('String encryption failed: $e');
    }
  }

  /// Decrypts a base64 string back to a plain string.
  String decryptToString(String base64) {
    try {
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      return encrypter.decrypt64(base64, iv: iv);
    } catch (e) {
      throw Exception('String decryption failed: $e');
    }
  }

  /// Generates a random 32-byte base64 encoded key.
  static String randomBase64Key() {
    final key = Key.fromSecureRandom(32);
    return key.base64;
  }

  /// Generates a random 16-byte base64 encoded IV.
  static String randomBase64Iv() {
    final iv = IV.fromSecureRandom(16);
    return iv.base64;
  }
}

