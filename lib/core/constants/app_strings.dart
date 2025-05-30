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
  static const String yourCredentials = "Credentials";
  static const String credentialDetail = "Credential Detail";
  static const String addCredentials = "Add your Credential";
  static const String updateCredentials = "Update your Credential";
  static const String userName = "User Name";
  static const String site = "Site";
  static const String password = "Password";
  static const String enterPassword = "Enter Password";
  static const String category = "Category";
  static const String save = "Save";
  static const String update = "Update";
  static const String enterUsername = "Enter username";
  static const String siteName = "Site Name";
  static const String enterSiteName = "Enter site name";
  static const String copyPasswordWarning = "Password copied to clipboard. It will be cleared in 30 seconds.";
  static const String copyPasswordToClipBoard = "Copy password to clipboard";

  //Password Generator
  static const String   passwordGenerator = "Password Generator";
  static const String   strength = "Strength";
  static const String   includeSymbols = "Include Symbols";
  static const String   includeNumbers = "Include Numbers";
  static const String   generatePassword = "Generate Password";
  static const String   useThePageToGenerateAPassword = "Use the page to generate a password.";

  // General
  static const String cancel = "Cancel";
  static const String ok = "OK";
  static const String securityVault = "Secure Vault";
  static const String delete = "Delete";
  static const String areYouSureWantToDelete = "Are you sure want to delete?";


  // Validation
  static const String fieldRequired = "This field is required";
}
