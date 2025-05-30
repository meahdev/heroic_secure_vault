import 'package:secure_vault/features/credential/domain/entities/category.dart';

import '../../../../core/utils/AESHelper.dart';
import '../../domain/entities/credential_entity.dart';

class CredentialModel {
  final String id;
  final String siteName;
  final String username;
  final String encryptedPassword;
  final Category category;
  final DateTime lastModified;

  CredentialModel({
    required this.id,
    required this.siteName,
    required this.username,
    required this.encryptedPassword,
    required this.category,
    required this.lastModified,

  });

  // Factory to create a model from entity (encrypt password)
  factory CredentialModel.fromEntity(CredentialEntity entity) {
    return CredentialModel(
      id: entity.id,
      siteName: entity.siteName,
      username: entity.username,
      encryptedPassword: AESHelper.encryptText(entity.password),
      category: entity.category,
      lastModified:entity.lastModified,
    );
  }

  // Convert model to entity (decrypt password)
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

  // JSON serialization (to store in local storage)
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

  // JSON deserialization (to load from local storage)
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
