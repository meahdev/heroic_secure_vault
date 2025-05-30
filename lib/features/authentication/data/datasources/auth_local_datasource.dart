import 'package:secure_vault/core/storage/secure_storage_service.dart';

import '../../../../core/utils/AESHelper.dart';

/// Contract defining local authentication-related operations.
abstract class AuthLocalDataSource {
  /// Stores the user's PIN securely.
  Future<void> savePin(String pin);

  /// Retrieves the stored PIN, if available.
  Future<String?> getPin();

  /// Checks whether a PIN is already stored.
  Future<bool> hasPin();

  /// Sets the biometric state of the application.

  Future<void> setBioMetric(bool isEnabled);

  /// Returns whether the app is currently in a locked state.
  Future<bool> isBioMetricEnabled();
}

/// Implementation of [AuthLocalDataSource] using [SecureStorageService].
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService storage;

  static const _pinKey = 'user_pin';
  static const _biometricKey = 'is_biometric';

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<void> savePin(String pin) async {
    final encryptedPin = AESHelper.encryptText(pin);
    await storage.write(key: _pinKey, value: encryptedPin);
  }

  @override
  Future<String?> getPin() async {
    final encryptedPin = await storage.read(key: _pinKey);
    if (encryptedPin == null) return null;
    final decryptedPin = AESHelper.decryptText(encryptedPin);
    if (decryptedPin == '[DECRYPTION_FAILED]') {
      // Handle failed decryption if needed
      return null;
    }
    return decryptedPin;
  }

  @override
  Future<bool> hasPin() async {
    return await storage.containsKey(key: _pinKey);
  }

  @override
  Future<bool> isBioMetricEnabled() async {
    final value = await storage.read(key: _biometricKey);
    return value == 'true';
  }

  @override
  Future<void> setBioMetric(bool isEnabled) async {
    await storage.write(key: _biometricKey, value: isEnabled.toString());
  }
}
