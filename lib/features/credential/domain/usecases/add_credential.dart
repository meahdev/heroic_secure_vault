import '../entities/credential_entity.dart';
import '../repositories/credential_repository.dart';

/// Use case class responsible for adding a credential.
/// Acts as an intermediary between the domain layer and repository.
class AddCredential {
  final CredentialRepository repository;

  /// Constructor accepting a CredentialRepository implementation.
  AddCredential(this.repository);

  /// Executes the use case to add the given credential.
  Future<void> call(CredentialEntity credential) async {
    await repository.addCredential(credential);
  }
}
