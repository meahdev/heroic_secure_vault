/// Enum representing levels of password strength
enum PasswordStrength { none, weak, medium, strong }

/// Calculates the strength of a given password based on length and character composition
PasswordStrength calculatePasswordStrength(String password) {
  // Return 'none' if password is empty
  if (password.isEmpty) return PasswordStrength.none;

  // Return 'weak' if password is shorter than 6 characters
  if (password.length < 6) return PasswordStrength.weak;

  // Check if password contains at least one uppercase letter
  final hasUpper = RegExp(r'[A-Z]').hasMatch(password);

  // Check if password contains at least one digit
  final hasDigits = RegExp(r'\d').hasMatch(password);

  // Check if password contains at least one special character
  final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  // If password is 10+ characters and contains uppercase, digit, and special character, it's strong
  if (password.length >= 10 && hasUpper && hasDigits && hasSpecial) {
    return PasswordStrength.strong;
  } else {
    // Otherwise, it's considered medium
    return PasswordStrength.medium;
  }
}
