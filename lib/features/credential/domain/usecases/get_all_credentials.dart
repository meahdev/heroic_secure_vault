
// get_all_credentials.dart
import '../entities/credential_entity.dart';
import '../repositories/credential_repository.dart';

class GetAllCredentials {
  final CredentialRepository repository;
  GetAllCredentials(this.repository);

  Future<List<CredentialEntity>> call() async {
    return await repository.getAllCredentials();
  }
}