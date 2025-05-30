import '../entities/credential_entity.dart';

abstract class CredentialRepository {
  Future<void> addCredential(CredentialEntity credential);

  Future<void> updateCredential(CredentialEntity credential);

  Future<void> deleteCredential(String id);

  Future<List<CredentialEntity>> getAllCredentials();
}
