enum PasswordStrength { none, weak, medium, strong }

PasswordStrength calculatePasswordStrength(String password) {
  if (password.isEmpty) return PasswordStrength.none;
  if (password.length < 6) return PasswordStrength.weak;

  final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
  final hasDigits = RegExp(r'\d').hasMatch(password);
  final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  if (password.length >= 10 && hasUpper && hasDigits && hasSpecial) {
    return PasswordStrength.strong;
  } else {
    return PasswordStrength.medium;
  }
}
