import 'dart:convert';

import '../../../../core/storage/secure_storage_service.dart';
import '../../../../core/utils/AESHelper.dart';
import '../model/credential_model.dart';

abstract class CredentialLocalDataSource {
  Future<void> insertCredential(CredentialModel credential);

  Future<void> updateCredential(CredentialModel credential);

  Future<void> deleteCredential(String id);

  Future<List<CredentialModel>> getAllCredentials();
}

class CredentialLocalDataSourceImpl implements CredentialLocalDataSource {
  final SecureStorageService secureStorage;
  static const _credentialsKey = 'credentials';

  CredentialLocalDataSourceImpl(this.secureStorage);

  @override
  Future<void> insertCredential(CredentialModel credential) async {
    final currentData = await _getRawData();
    currentData[credential.id] = _toStorageMap(credential);
    await _saveRawData(currentData);
  }

  @override
  Future<void> updateCredential(CredentialModel credential) async {
    final currentData = await _getRawData();
    if (!currentData.containsKey(credential.id)) {
      throw Exception("Credential not found");
    }
    currentData[credential.id] = _toStorageMap(credential);
    await _saveRawData(currentData);
  }

  @override
  Future<void> deleteCredential(String id) async {
    final currentData = await _getRawData();
    currentData.remove(id);
    await _saveRawData(currentData);
  }

  @override
  Future<List<CredentialModel>> getAllCredentials() async {
    final currentData = await _getRawData();
    return currentData.values
        .map((map) => CredentialModel.fromJson(Map<String, dynamic>.from(map)))
        .toList()
      ..sort((a, b) => b.lastModified.compareTo(a.lastModified));
  }

  Future<Map<String, dynamic>> _getRawData() async {
    final rawString = await secureStorage.read(key: _credentialsKey);
    if (rawString == null || rawString.isEmpty) return {};
    return Map<String, dynamic>.from(await jsonDecode(rawString));
  }

  Future<void> _saveRawData(Map<String, dynamic> data) async {
    await secureStorage.write(key: _credentialsKey, value: jsonEncode(data));
  }

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
