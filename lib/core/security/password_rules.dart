import 'package:secure_vault/core/security/password_strength.dart';

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  final strength = calculatePasswordStrength(value);
  if (strength == PasswordStrength.weak) {
    return 'Password is too weak';
  }
  return null;
}
