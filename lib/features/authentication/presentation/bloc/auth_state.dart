part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial state when nothing happened yet
class AuthInitial extends AuthState {}

// When user needs to confirm the PIN (second entry)
class SetPinConfirmState extends AuthState {
  final String firstPin;
  final String id;

  const SetPinConfirmState(this.firstPin, this.id);

  @override
  List<Object?> get props => [firstPin, id];
}

// When PIN is saved successfully
class PinSavedState extends AuthState {}

class PinNotSavedState extends AuthState {}

// When BioMetric is saved successfully
class BioMetricSavedState extends AuthState {}

class BioMetricNotSavedState extends AuthState {}

// When PIN verification is successful
class PinVerifiedState extends AuthState {}

// When PIN verification fails
class PinVerificationFailedState extends AuthState {
  final String msg;
  final String id;

  const PinVerificationFailedState(this.msg, this.id);

  @override
  List<Object?> get props => [msg, id];
}

// When Set PIN verification fails
class SetPinFailedState extends AuthState {
  final String msg;
  final String id;

  const SetPinFailedState(this.msg, this.id);

  @override
  List<Object?> get props => [msg, id];
}

// When Confirm PIN verification fails
class ConfirmPinFailedState extends AuthState {
  final String msg;
  final String id;

  const ConfirmPinFailedState(this.msg, this.id);

  @override
  List<Object?> get props => [msg, id];
}

// When lock state updated
class LockUpdatedState extends AuthState {
  final bool locked;

  const LockUpdatedState(this.locked);

  @override
  List<Object?> get props => [locked];
}

// When lock status is known
class LockStatusState extends AuthState {
  final bool locked;

  const LockStatusState(this.locked);

  @override
  List<Object?> get props => [locked];
}

// When biometric authentication succeeds
class BiometricAuthSuccessState extends AuthState {}

// When biometric authentication fails
class BiometricAuthFailedState extends AuthState {
  final String msg;
  final String id;
  const BiometricAuthFailedState(this.msg, this.id);

  @override
  List<Object?> get props => [msg, id];
}

// Loading state for async operations
class AuthLoading extends AuthState {}
