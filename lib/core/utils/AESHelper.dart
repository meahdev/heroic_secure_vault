import 'package:encrypt/encrypt.dart';

class AESHelper {
  // Key must be 32 bytes (for AES-256)
  static final _key = Key.fromUtf8('12345678901234567890123456789012'); // 32 chars

  // IV must be 16 bytes
  static final _iv = IV.fromUtf8('1234567890123456'); // 16 chars

  static final _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

  static String encryptText(String text) {
    return _encrypter.encrypt(text, iv: _iv).base64;
  }

  static String decryptText(String encrypted) {
    try {
      return _encrypter.decrypt64(encrypted, iv: _iv);
    } catch (e, stackTrace) {
      return '[DECRYPTION_FAILED]';
    }
  }
}
