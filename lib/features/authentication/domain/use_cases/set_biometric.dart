import '../repositories/auth_repository.dart';

/// Use case to securely save the user bio metric state.
class SetBioMetric {
  final AuthRepository repository;

  SetBioMetric(this.repository);

  /// Saves the biometric using the underlying repository.
  Future<void> call(bool isEnabled) => repository.setBioMetric(isEnabled);
}
