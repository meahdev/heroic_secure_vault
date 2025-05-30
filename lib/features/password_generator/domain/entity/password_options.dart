/// Represents the options/settings for password generation.
class PasswordOptions {
  /// Desired length of the generated password.
  final int length;

  /// Whether to include numeric characters in the password.
  final bool includeNumbers;

  /// Whether to include symbol characters in the password.
  final bool includeSymbols;

  /// Constructs a [PasswordOptions] instance.
  ///
  /// [length] is required.
  /// [includeNumbers] and [includeSymbols] default to true.
  const PasswordOptions({
    required this.length,
    this.includeNumbers = true,
    this.includeSymbols = true,
  });
}
