
import '../../domain/entities/credential_entity.dart';
import '../../domain/repositories/credential_repository.dart';
import '../datasources/credential_local_datasource.dart';
import '../model/credential_model.dart';

class CredentialRepositoryImpl implements CredentialRepository {
  final CredentialLocalDataSource localDataSource;

  CredentialRepositoryImpl(this.localDataSource);

  @override
  Future<void> addCredential(CredentialEntity credential) async {
    final model = CredentialModel.fromEntity(credential);
    await localDataSource.insertCredential(model);
  }

  @override
  Future<void> updateCredential(CredentialEntity credential) async {
    final model = CredentialModel.fromEntity(credential);
    await localDataSource.updateCredential(model);
  }

  @override
  Future<void> deleteCredential(String id) async {
    await localDataSource.deleteCredential(id);
  }

  @override
  Future<List<CredentialEntity>> getAllCredentials() async {
    final models = await localDataSource.getAllCredentials();
    return models.map((model) => model.toEntity()).toList();
  }
}