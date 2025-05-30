part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial state when nothing has happened yet
class AuthInitial extends AuthState {}

// When user has entered the first PIN and needs to confirm it (second entry)
class SetPinConfirmState extends AuthState {
  final String firstPin;
  final String id; // Unique id or timestamp to differentiate state instances

  const SetPinConfirmState(this.firstPin, this.id);

  @override
  List<Object?> get props => [firstPin, id];
}

// When PIN has been saved successfully
class PinSavedState extends AuthState {}

// When no PIN is saved yet (fresh install or no PIN set)
class PinNotSavedState extends AuthState {}

// When biometric authentication is enabled and saved
class BioMetricSavedState extends AuthState {}

// When biometric authentication is not enabled
class BioMetricNotSavedState extends AuthState {}

// When PIN verification succeeded (correct PIN entered)
class PinVerifiedState extends AuthState {}

// When PIN verification failed (wrong PIN entered)
class PinVerificationFailedState extends AuthState {
  final String msg; // Error message to show
  final String id;  // Timestamp/id to differentiate multiple failures

  const PinVerificationFailedState(this.msg, this.id);

  @override
  List<Object?> get props => [msg, id];
}

// When the initial PIN entered during setup is invalid according to rules
class SetPinFailedState extends AuthState {
  final String msg;
  final String id;

  const SetPinFailedState(this.msg, this.id);

  @override
  List<Object?> get props => [msg, id];
}

// When the confirmation PIN doesn't match the first PIN entered
class ConfirmPinFailedState extends AuthState {
  final String msg;
  final String id;

  const ConfirmPinFailedState(this.msg, this.id);

  @override
  List<Object?> get props => [msg, id];
}

// When the app lock state is updated (locked/unlocked)
class LockUpdatedState extends AuthState {
  final bool locked;

  const LockUpdatedState(this.locked);

  @override
  List<Object?> get props => [locked];
}

// When lock status is retrieved (useful on app start or state restore)
class LockStatusState extends AuthState {
  final bool locked;

  const LockStatusState(this.locked);

  @override
  List<Object?> get props => [locked];
}

// When biometric authentication is successful
class BiometricAuthSuccessState extends AuthState {}

// When biometric authentication fails
class BiometricAuthFailedState extends AuthState {
  final String msg; // Error message to show on biometric failure
  final String id;

  const BiometricAuthFailedState(this.msg, this.id);

  @override
  List<Object?> get props => [msg, id];
}

// Generic loading state for async operations like saving/verifying PIN or biometrics
class AuthLoading extends AuthState {}
