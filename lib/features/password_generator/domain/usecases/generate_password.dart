import 'package:secure_vault/features/password_generator/domain/entity/password_options.dart';
import '../repositories/password_repository.dart';

/// Use case for generating a secure password based on [PasswordOptions].
class GeneratePassword {
  final PasswordGeneratorRepository repository;

  GeneratePassword(this.repository);

  /// Generates and returns a password using the provided [options].
  String call(PasswordOptions options) => repository.generatePassword(options);
}
