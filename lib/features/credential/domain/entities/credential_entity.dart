import 'package:secure_vault/features/credential/domain/entities/category.dart';


class CredentialEntity {
  final String id;
  final String siteName;
  final String username;
  final String password;
  final Category category;
  final DateTime lastModified;

  const CredentialEntity({
    required this.id,
    required this.siteName,
    required this.username,
    required this.password,
    required this.category,
    required this.lastModified
  });
}