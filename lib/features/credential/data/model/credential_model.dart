import 'package:secure_vault/features/credential/domain/entities/category.dart';

import '../../../../core/utils/AESHelper.dart';
import '../../domain/entities/credential_entity.dart';

/// Data model class for Credential, used for local storage and data manipulation.
/// Handles encryption/decryption when converting between entity and model.
class CredentialModel {
  final String id;
  final String siteName;
  final String username;
  final String encryptedPassword;
  final Category category;
  final DateTime lastModified;

  /// Constructor for initializing a CredentialModel instance.
  CredentialModel({
    required this.id,
    required this.siteName,
    required this.username,
    required this.encryptedPassword,
    required this.category,
    required this.lastModified,
  });

  /// Factory constructor to create a CredentialModel from a CredentialEntity.
  /// Encrypts the plain text password before storing.
  factory CredentialModel.fromEntity(CredentialEntity entity) {
    return CredentialModel(
      id: entity.id,
      siteName: entity.siteName,
      username: entity.username,
      encryptedPassword: AESHelper.encryptText(entity.password),
      category: entity.category,
      lastModified: entity.lastModified,
    );
  }

  /// Converts this model back to a CredentialEntity.
  /// Decrypts the stored encrypted password before returning the entity.
  CredentialEntity toEntity() {
    return CredentialEntity(
      id: id,
      siteName: siteName,
      username: username,
      password: AESHelper.decryptText(encryptedPassword),
      category: category,
      lastModified: lastModified,
    );
  }

  /// Serializes this model into a JSON-compatible Map for storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'siteName': siteName,
      'username': username,
      'encryptedPassword': encryptedPassword,
      'category': category.toJson(),
      'lastModified': lastModified.toIso8601String(),
    };
  }

  /// Factory constructor to create a CredentialModel from JSON map.
  /// Used for deserialization when loading from storage.
  factory CredentialModel.fromJson(Map<String, dynamic> json) {
    return CredentialModel(
      id: json['id'],
      siteName: json['siteName'],
      username: json['username'],
      encryptedPassword: json['encryptedPassword'],
      category: Category.fromJson(json['category']),
      lastModified: DateTime.parse(json['lastModified']),
    );
  }
}
