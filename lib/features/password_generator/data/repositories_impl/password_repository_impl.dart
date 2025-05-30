import 'package:secure_vault/features/password_generator/domain/entity/password_options.dart';

import '../../../../core/utils/password_generator_util.dart';
import '../../domain/repositories/password_repository.dart';

/// Implementation of [PasswordGeneratorRepository] that
/// delegates password generation and strength evaluation
/// to [PasswordGeneratorUtil].
class PasswordGeneratorRepositoryImpl implements PasswordGeneratorRepository {

  /// Generates a password based on the provided [options].
  @override
  String generatePassword(PasswordOptions options) {
    return PasswordGeneratorUtil.generate(
      length: options.length,
      includeNumbers: options.includeNumbers,
      includeSymbols: options.includeSymbols,
    );
  }

  /// Evaluates the strength of the given [password].
  @override
  String evaluatePasswordStrength(String password) {
    return PasswordGeneratorUtil.evaluateStrength(password);
  }
}
