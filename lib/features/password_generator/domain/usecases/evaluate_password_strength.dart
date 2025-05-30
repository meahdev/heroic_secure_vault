import '../repositories/password_repository.dart';

/// Use case for evaluating the strength of a password.
class EvaluatePasswordStrength {
  final PasswordGeneratorRepository repository;

  EvaluatePasswordStrength(this.repository);

  /// Returns a strength label or score for the given [password].
  String call(String password) => repository.evaluatePasswordStrength(password);
}
