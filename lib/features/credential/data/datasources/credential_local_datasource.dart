import 'dart:convert';

import '../../../../core/storage/secure_storage_service.dart';
import '../model/credential_model.dart';

/// Abstract data source for local credential storage operations.
abstract class CredentialLocalDataSource {
  /// Inserts a new credential into local storage.
  Future<void> insertCredential(CredentialModel credential);

  /// Updates an existing credential in local storage.
  Future<void> updateCredential(CredentialModel credential);

  /// Deletes a credential from local storage by id.
  Future<void> deleteCredential(String id);

  /// Retrieves all stored credentials, sorted by last modified date.
  Future<List<CredentialModel>> getAllCredentials();
}

/// Implementation of the local data source using secure storage.
class CredentialLocalDataSourceImpl implements CredentialLocalDataSource {
  final SecureStorageService secureStorage;

  // Key used to store the credentials JSON string in secure storage.
  static const _credentialsKey = 'credentials';

  CredentialLocalDataSourceImpl(this.secureStorage);

  /// Inserts a new credential after fetching current stored data.
  /// Adds the new credential and saves updated data.
  @override
  Future<void> insertCredential(CredentialModel credential) async {
    final currentData = await _getRawData();
    currentData[credential.id] = _toStorageMap(credential);
    await _saveRawData(currentData);
  }

  /// Updates an existing credential if it exists.
  /// Throws an exception if the credential is not found.
  @override
  Future<void> updateCredential(CredentialModel credential) async {
    final currentData = await _getRawData();
    if (!currentData.containsKey(credential.id)) {
      throw Exception("Credential not found");
    }
    currentData[credential.id] = _toStorageMap(credential);
    await _saveRawData(currentData);
  }

  /// Deletes a credential by its id and saves the updated data.
  @override
  Future<void> deleteCredential(String id) async {
    final currentData = await _getRawData();
    currentData.remove(id);
    await _saveRawData(currentData);
  }

  /// Retrieves all credentials, converts stored maps to CredentialModel,
  /// and sorts them by last modified date in descending order.
  @override
  Future<List<CredentialModel>> getAllCredentials() async {
    final currentData = await _getRawData();
    return currentData.values
        .map((map) => CredentialModel.fromJson(Map<String, dynamic>.from(map)))
        .toList()
      ..sort((a, b) => b.lastModified.compareTo(a.lastModified));
  }

  /// Helper method to get raw stored JSON data as a Map.
  /// Returns an empty map if no data is found.
  Future<Map<String, dynamic>> _getRawData() async {
    final rawString = await secureStorage.read(key: _credentialsKey);
    if (rawString == null || rawString.isEmpty) return {};
    return Map<String, dynamic>.from(await jsonDecode(rawString));
  }

  /// Helper method to save the given Map as a JSON string into secure storage.
  Future<void> _saveRawData(Map<String, dynamic> data) async {
    await secureStorage.write(key: _credentialsKey, value: jsonEncode(data));
  }

  /// Converts a CredentialModel into a Map suitable for storage.
  /// Password is expected to be encrypted before storage.
  Map<String, dynamic> _toStorageMap(CredentialModel credential) {
    // Encrypt password before storage
    return {
      'id': credential.id,
      'siteName': credential.siteName,
      'username': credential.username,
      'encryptedPassword': credential.encryptedPassword,
      // encrypt here
      'category': credential.category.toJson(), // ✅ fixed
      'lastModified': credential.lastModified.toIso8601String(),
    };
  }
}
