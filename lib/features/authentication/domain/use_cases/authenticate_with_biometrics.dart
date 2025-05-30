import '../repositories/auth_repository.dart';

/// Use case for biometric authentication.
class AuthenticateWithBiometrics {
  final AuthRepository repository;

  AuthenticateWithBiometrics(this.repository);

  /// Executes biometric authentication.
  Future<bool> call() => repository.authenticateWithBiometrics();
}
