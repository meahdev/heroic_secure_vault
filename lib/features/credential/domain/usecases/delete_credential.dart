import '../repositories/credential_repository.dart';

/// Use case class responsible for deleting a credential by ID.
/// Provides an abstraction for deleting credentials via the repository.
class DeleteCredential {
  final CredentialRepository repository;

  /// Constructor accepting a CredentialRepository implementation.
  DeleteCredential(this.repository);

  /// Executes the use case to delete a credential by its ID.
  Future<void> call(String id) async {
    await repository.deleteCredential(id);
  }
}
