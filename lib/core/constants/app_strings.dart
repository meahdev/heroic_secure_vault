/// Defines all static string constants used throughout the application.
/// Useful for localization and consistent text management.
class AppStrings {
  // Authentication
  static const String create4DigitPin = "Create 4 Digit PIN";
  static const String confirmPin = "Confirm PIN";
  static const String secureVaultLocked = "Secure Vault Locked";
  static const String enterPin = "Enter PIN";
  static const String inCorrectPin = "Incorrect PIN";
  static const String pinsDoNotMatch = "Pins do not match. Please try again.";
  static const String pinBlock =
      "PIN must not contain identical or sequential digits.";
  static const String pinDoesNotMatch = "PIN does not match";
  static const String pinInstruction =
      "You will be asked to enter the PIN every time you try to access a 'Secure Vault' service. "
      "After verifying your PIN, we'll offer the option to enable biometric authentication for faster access. "
      "If your device doesn't support biometrics or you prefer not to use them, you can continue using your PIN to access the vault.";

  // Biometric
  static const String biometricAuthenticationEnabled =
      "Biometric authentication enabled!";
  static const String biometricAuthenticationFallback =
      "Couldn't verify with biometrics, but your PIN unlocked the app.";
  static const String biometricAuthenticationFailed =
      "Biometric authentication failed";
  static const String unlockWithBiometric = "Click to Unlock with Biometric";

  // Credential
  static const String yourCredentials = "Your Credentials";

  // General
  static const String cancel = "Cancel";
  static const String ok = "OK";
  static const String securityVault = "Secure Vault";
  static const String reinstallAppInstruction =
      "To reset your PIN, you will need to uninstall and reinstall the application.";
}
