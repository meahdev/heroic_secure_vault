import 'package:secure_vault/features/credential/domain/entities/category.dart';

/// Entity class representing a credential in the domain layer.
/// Contains all properties in plain (unencrypted) form.
class CredentialEntity {
  final String id;
  final String siteName;
  final String username;
  final String password; // Plain text password here
  final Category category;
  final DateTime lastModified;

  /// Constructor for creating an immutable CredentialEntity instance.
  const CredentialEntity({
    required this.id,
    required this.siteName,
    required this.username,
    required this.password,
    required this.category,
    required this.lastModified,
  });
}
