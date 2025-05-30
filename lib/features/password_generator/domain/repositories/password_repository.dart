import 'package:secure_vault/features/password_generator/domain/entity/password_options.dart';

/// Abstract repository for password generation and evaluation.
abstract class PasswordGeneratorRepository {
  /// Generates a password based on the given [options].
  ///
  /// This uses options like length, inclusion of numbers and symbols
  /// to construct a secure password.
  String generatePassword(PasswordOptions options);

  /// Evaluates the strength of a given [password].
  ///
  /// Can return a qualitative label (e.g., "Weak", "Strong") or an entropy score.
  String evaluatePasswordStrength(String password);
}
