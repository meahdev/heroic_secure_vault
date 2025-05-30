import '../entities/credential_entity.dart';
import '../repositories/credential_repository.dart';

class UpdateCredential {
  final CredentialRepository repository;
  UpdateCredential(this.repository);

  Future<void> call(CredentialEntity credential) async {
    await repository.updateCredential(credential);
  }
}