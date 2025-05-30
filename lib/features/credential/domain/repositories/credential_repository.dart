import '../entities/credential_entity.dart';

/// Abstract repository defining the contract for managing credentials.
/// Implementations handle the data operations for credentials in the domain layer.
abstract class CredentialRepository {
  /// Adds a new credential to the repository.
  Future<void> addCredential(CredentialEntity credential);

  /// Updates an existing credential in the repository.
  Future<void> updateCredential(CredentialEntity credential);

  /// Deletes a credential by its ID from the repository.
  Future<void> deleteCredential(String id);

  /// Retrieves all credentials stored in the repository.
  Future<List<CredentialEntity>> getAllCredentials();
}
