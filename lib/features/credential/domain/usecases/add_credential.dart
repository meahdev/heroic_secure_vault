import '../entities/credential_entity.dart';
import '../repositories/credential_repository.dart';

class AddCredential {
  final CredentialRepository repository;
  AddCredential(this.repository);

  Future<void> call(CredentialEntity credential) async {
    await repository.addCredential(credential);
  }
}