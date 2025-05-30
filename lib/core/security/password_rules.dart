import 'package:secure_vault/core/security/password_strength.dart';

/// Checks the provided password against defined rules and returns an error message if it fails
String? passwordRules(String? value) {
  // Validate that the password is not null or empty
  if (value == null || value.isEmpty) return 'Password is required';

  // Evaluate the strength of the password
  final strength = calculatePasswordStrength(value);

  // If password strength is weak, return an appropriate error message
  if (strength == PasswordStrength.weak) {
    return 'Password is too weak';
  }

  // Return null if all rules pass (valid password)
  return null;
}
