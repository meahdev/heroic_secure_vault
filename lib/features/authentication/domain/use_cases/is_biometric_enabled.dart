import '../repositories/auth_repository.dart';

/// Use case to check whether the user has already set biometric.
class IsBiometricEnabled {
  final AuthRepository repository;

  IsBiometricEnabled(this.repository);

  /// Returns `true` if biometric state is already stored, otherwise `false`.
  Future<bool> call() => repository.isBioMetricEnabled();
}
