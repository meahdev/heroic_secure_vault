import '../repositories/auth_repository.dart';

/// Use case to verify a PIN.
class VerifyPin {
  final AuthRepository repository;

  VerifyPin(this.repository);

  /// Verifies the given [pin].
  Future<bool> call(String pin) => repository.verifyPin(pin);
}
