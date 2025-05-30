import '../entities/credential_entity.dart';
import '../repositories/credential_repository.dart';

/// Use case class responsible for updating an existing credential.
/// Provides an abstraction to update credentials via the repository.
class UpdateCredential {
  final CredentialRepository repository;

  /// Constructor accepting a CredentialRepository implementation.
  UpdateCredential(this.repository);

  /// Executes the use case to update the given credential.
  Future<void> call(CredentialEntity credential) async {
    await repository.updateCredential(credential);
  }
}
