// Importing Equatable for value-based equality in state and event classes
import 'package:equatable/equatable.dart';

// Importing Flutter BLoC package for state management
import 'package:flutter_bloc/flutter_bloc.dart';

// Importing domain entities and use cases
import '../../domain/entity/password_options.dart';
import '../../domain/usecases/evaluate_password_strength.dart';
import '../../domain/usecases/generate_password.dart';

// Including part files for event and state definitions
part 'password_generator_event.dart';
part 'password_generator_state.dart';

// BLoC class to handle password generation and strength evaluation logic
class PasswordGeneratorBloc extends Bloc<PasswordGeneratorEvent, PasswordGeneratorState> {
  // Use case to generate a password based on given options
  final GeneratePassword generatePassword;

  // Use case to evaluate the strength of a generated password
  final EvaluatePasswordStrength evaluateStrength;

  // Constructor initializing use cases and defining event handlers
  PasswordGeneratorBloc({
    required this.generatePassword,
    required this.evaluateStrength,
  }) : super(PasswordInitial()) {
    // Handling GeneratePasswordEvent
    on<GeneratePasswordEvent>((event, emit) {
      // Emit loading state while generating the password
      emit(PasswordLoading());

      // Generate the password using provided options
      final password = generatePassword(event.options);

      // Evaluate the strength of the generated password
      final strength = evaluateStrength(password);

      // Emit the final state with the generated password and its strength
      emit(PasswordGenerated(password, strength));
    });
  }
}
