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

  /// Locks the app.
  Future<void> lock();

  /// Checks if the app is currently locked.
  Future<bool> isLocked();
}
