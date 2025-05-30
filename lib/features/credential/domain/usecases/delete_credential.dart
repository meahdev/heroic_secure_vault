// delete_credential.dart
import '../repositories/credential_repository.dart';

class DeleteCredential {
  final CredentialRepository repository;
  DeleteCredential(this.repository);

  Future<void> call(String id) async {
    await repository.deleteCredential(id);
  }
}