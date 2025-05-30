import 'package:encrypt/encrypt.dart';

/// Helper class to perform AES-256 encryption and decryption.
///
/// Uses CBC mode with a fixed 32-byte key and 16-byte initialization vector (IV).
class AESHelper {
  // AES key must be 32 bytes long for AES-256 encryption.
  static final _key = Key.fromUtf8('12345678901234567890123456789012'); // 32 chars

  // Initialization Vector (IV) must be 16 bytes for AES-CBC mode.
  static final _iv = IV.fromUtf8('1234567890123456'); // 16 chars

  // Encrypter instance configured with AES algorithm and CBC mode.
  static final _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

  /// Encrypts a plain text string and returns the encrypted data as a base64 string.
  static String encryptText(String text) {
    return _encrypter.encrypt(text, iv: _iv).base64;
  }

  /// Decrypts a base64 encoded encrypted string.
  ///
  /// Returns the decrypted plain text on success.
  /// Returns '[DECRYPTION_FAILED]' if decryption throws an error.
  static String decryptText(String encrypted) {
    try {
      return _encrypter.decrypt64(encrypted, iv: _iv);
    } catch (e, stackTrace) {
      // Could log error and stackTrace here if needed.
      return '[DECRYPTION_FAILED]';
    }
  }
}
