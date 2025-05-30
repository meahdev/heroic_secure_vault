// Declares this file as part of 'password_generator_bloc.dart'
part of 'password_generator_bloc.dart';

// Abstract base class for all password generator events
abstract class PasswordGeneratorEvent extends Equatable {
  const PasswordGeneratorEvent();

  // Props for Equatable to enable value comparison
  @override
  List<Object?> get props => [];
}

// Event to trigger password generation with given options
class GeneratePasswordEvent extends PasswordGeneratorEvent {
  // Password generation options (e.g., length, use of symbols, etc.)
  final PasswordOptions options;

  // Constructor to initialize options
  const GeneratePasswordEvent(this.options);

  // Props used for equality comparison
  @override
  List<Object?> get props => [options];
}
