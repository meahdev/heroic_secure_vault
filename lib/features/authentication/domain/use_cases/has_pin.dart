import '../repositories/auth_repository.dart';

/// Use case to check whether the user has already set a PIN.
class HasPin {
  final AuthRepository repository;

  HasPin(this.repository);

  /// Returns `true` if a PIN is already stored, otherwise `false`.
  Future<bool> call() => repository.hasPin();
}
