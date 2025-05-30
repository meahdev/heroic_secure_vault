import '../entities/credential_entity.dart';
import '../repositories/credential_repository.dart';

/// Use case class responsible for retrieving all credentials.
/// Acts as an abstraction layer between domain logic and repository.
class GetAllCredentials {
  final CredentialRepository repository;

  /// Constructor accepting a CredentialRepository implementation.
  GetAllCredentials(this.repository);

  /// Executes the use case to fetch all credentials.
  Future<List<CredentialEntity>> call() async {
    return await repository.getAllCredentials();
  }
}
