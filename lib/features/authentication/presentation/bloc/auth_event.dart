part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// User entered first PIN (for setting)
class PinEntered extends AuthEvent {
  final String pin;

  const PinEntered(this.pin);

  @override
  List<Object?> get props => [pin];
}

// User confirmed PIN (second time)
class PinConfirmed extends AuthEvent {
  final String firstPin;
  final String confirmPin;

  const PinConfirmed({required this.firstPin, required this.confirmPin});

  @override
  List<Object?> get props => [firstPin, confirmPin];
}

// Triggered when user wants to verify entered PIN
class VerifyPinEvent extends AuthEvent {
  final String pin;

  const VerifyPinEvent(this.pin);

  @override
  List<Object?> get props => [pin];
}

// Triggered when app needs to check if a PIN exists
class CheckHasPinEvent extends AuthEvent {}

// Triggered when app needs to check if biometric enabled
class CheckHasBioMetricEvent extends AuthEvent {}

// Triggered when lock state changes
class SetLockEvent extends AuthEvent {
  final bool locked;

  const SetLockEvent(this.locked);

  @override
  List<Object?> get props => [locked];
}


// Triggered for biometric authentication
class AuthenticateBiometricsEvent extends AuthEvent {}


