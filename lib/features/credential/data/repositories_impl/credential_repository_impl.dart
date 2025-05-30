import '../../domain/entities/credential_entity.dart';
import '../../domain/repositories/credential_repository.dart';
import '../datasources/credential_local_datasource.dart';
import '../model/credential_model.dart';

/// Implementation of CredentialRepository that uses
/// a local data source to manage credential data.
class CredentialRepositoryImpl implements CredentialRepository {
  final CredentialLocalDataSource localDataSource;

  /// Constructor accepting a local data source instance.
  CredentialRepositoryImpl(this.localDataSource);

  /// Adds a new credential by converting entity to model,
  /// then delegating to the local data source for insertion.
  @override
  Future<void> addCredential(CredentialEntity credential) async {
    final model = CredentialModel.fromEntity(credential);
    await localDataSource.insertCredential(model);
  }

  /// Updates an existing credential by converting entity to model,
  /// then delegating to the local data source for update.
  @override
  Future<void> updateCredential(CredentialEntity credential) async {
    final model = CredentialModel.fromEntity(credential);
    await localDataSource.updateCredential(model);
  }

  /// Deletes a credential by its ID via the local data source.
  @override
  Future<void> deleteCredential(String id) async {
    await localDataSource.deleteCredential(id);
  }

  /// Retrieves all stored credentials from local data source,
  /// then converts models back to entities for domain use.
  @override
  Future<List<CredentialEntity>> getAllCredentials() async {
    final models = await localDataSource.getAllCredentials();
    return models.map((model) => model.toEntity()).toList();
  }
}
