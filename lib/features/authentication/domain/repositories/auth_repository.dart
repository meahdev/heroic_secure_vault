/// Contract for authentication-related operations.
///
/// Handles PIN and biometric authentication and app lock state.
abstract class AuthRepository {
  /// Verifies the provided PIN.
  Future<bool> verifyPin(String pin);

  /// Saves the PIN securely.
  Future<void> savePin(String pin);

  /// Performs biometric authentication.
  Future<bool> authenticateWithBiometrics();

  /// Checks if a PIN is set.
  Future<bool> hasPin();
  /// Saves the biometric state.
  Future<void> setBioMetric(bool isEnabled);

  /// Checks if a biometric is enabled.
  Future<bool> isBioMetricEnabled();

}
