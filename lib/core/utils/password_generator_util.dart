import 'dart:math';

/// Utility class for generating random passwords and evaluating their strength.
class PasswordGeneratorUtil {
  // Character sets for password generation
  static const _lowercase = 'abcdefghijklmnopqrstuvwxyz';
  static const _uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _numbers = '0123456789';
  static const _symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

  /// Generates a random password string of the given [length].
  ///
  /// Optional parameters allow including numbers and symbols in the password.
  /// Password will always include uppercase and lowercase letters.
  static String generate({
    required int length,
    bool includeNumbers = true,
    bool includeSymbols = true,
  }) {
    // Compose the allowed character set based on options
    String chars = _lowercase + _uppercase;
    if (includeNumbers) chars += _numbers;
    if (includeSymbols) chars += _symbols;

    final rand = Random.secure();

    // Generate password by randomly picking characters from allowed set
    return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  /// Evaluates the strength of a given [password] string.
  ///
  /// Returns a string label: 'Weak', 'Fair', 'Good', or 'Strong'.
  /// Scoring is based on length and presence of uppercase letters, numbers, and symbols.
  static String evaluateStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;                    // Length requirement
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;      // Contains uppercase
    if (RegExp(r'[0-9]').hasMatch(password)) score++;      // Contains digits
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) score++; // Contains symbols

    switch (score) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return 'Unknown';
    }
  }
}
