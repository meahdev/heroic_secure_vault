import '../repositories/auth_repository.dart';

/// Use case to securely save the user's PIN.
class SavePin {
  final AuthRepository repository;

  SavePin(this.repository);

  /// Saves the provided [pin] using the underlying repository.
  Future<void> call(String pin) => repository.savePin(pin);
}
