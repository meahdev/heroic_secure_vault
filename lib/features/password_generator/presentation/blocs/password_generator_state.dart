// Declares this file as part of 'password_generator_bloc.dart'
part of 'password_generator_bloc.dart';

// Abstract base class for all password generator states
abstract class PasswordGeneratorState extends Equatable {
  const PasswordGeneratorState();

  // Props for Equatable to enable value-based comparison
  @override
  List<Object?> get props => [];
}

// Initial state before any password generation action is taken
class PasswordInitial extends PasswordGeneratorState {}

// State emitted while the password is being generated
class PasswordLoading extends PasswordGeneratorState {}

// State emitted after password is generated and strength is evaluated
class PasswordGenerated extends PasswordGeneratorState {
  // The generated password
  final String password;

  // The evaluated strength of the generated password
  final String strength;

  // Constructor to initialize password and strength
  const PasswordGenerated(this.password, this.strength);

  // Props used for value comparison in Equatable
  @override
  List<Object?> get props => [password, strength];
}
