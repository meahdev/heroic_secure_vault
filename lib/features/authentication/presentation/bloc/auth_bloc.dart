import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_vault/core/constants/app_strings.dart';
import 'package:secure_vault/core/security/pin_rules.dart';

import '../../domain/use_cases/authenticate_with_biometrics.dart';
import '../../domain/use_cases/has_pin.dart';
import '../../domain/use_cases/is_biometric_enabled.dart';
import '../../domain/use_cases/save_pin.dart';
import '../../domain/use_cases/set_biometric.dart';
import '../../domain/use_cases/verify_pin.dart';


part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SavePin savePin;
  final VerifyPin verifyPin;
  final HasPin hasPin;
  final SetBioMetric setBioMetric;
  final IsBiometricEnabled isBiometricEnabled;
  final AuthenticateWithBiometrics authenticateWithBiometrics;

  AuthBloc({
    required this.savePin,
    required this.verifyPin,
    required this.hasPin,
    required this.authenticateWithBiometrics,
    required this.isBiometricEnabled,
    required this.setBioMetric,
  }) : super(AuthInitial()) {

    // Event when user enters PIN initially; validate rules (not sequential, etc.)
    on<PinEntered>((event, emit) async {
      if (!PinRules.isValid(event.pin)) {
        // Invalid PIN pattern, reject with failure state
        emit(SetPinFailedState(AppStrings.pinBlock, DateTime.now().toString()));
        return;
      }
      // Valid PIN, prompt for confirmation
      emit(SetPinConfirmState(event.pin, DateTime.now().toString()));
    });

    // Event when user confirms the PIN
    on<PinConfirmed>((event, emit) async {
      if (event.firstPin == event.confirmPin) {
        emit(AuthLoading());
        // Save PIN securely
        await savePin.call(event.confirmPin);
        emit(PinSavedState());
      } else {
        // Confirmation doesn't match initial PIN
        emit(
          ConfirmPinFailedState(
            AppStrings.pinDoesNotMatch,
            DateTime.now().toString(),
          ),
        );
      }
    });

    // Event to verify entered PIN for authentication
    on<VerifyPinEvent>((event, emit) async {
      emit(AuthLoading());
      final valid = await verifyPin(event.pin);
      if (valid) {
        emit(PinVerifiedState());
      } else {
        emit(
          PinVerificationFailedState(
            AppStrings.pinDoesNotMatch,
            DateTime.now().toString(),
          ),
        );
      }
    });

    // Check if a PIN is already saved (e.g. on app start)
    on<CheckHasPinEvent>((event, emit) async {
      emit(AuthLoading());
      final exists = await hasPin();
      emit(exists ? PinSavedState() : PinNotSavedState());
    });

    // Check if biometric auth is enabled
    on<CheckHasBioMetricEvent>((event, emit) async {
      emit(AuthLoading());
      final exists = await isBiometricEnabled();
      if (exists) {
        emit(BioMetricSavedState());
      } else {
        // If biometrics not enabled, fallback to check PIN
        add(CheckHasPinEvent());
      }
    });

    // Event to toggle app lock state
    on<SetLockEvent>((event, emit) async {
      emit(LockUpdatedState(event.locked));
    });

    // Authenticate user via biometrics (e.g. fingerprint, face)
    on<AuthenticateBiometricsEvent>((event, emit) async {
      emit(AuthLoading());
      final success = await authenticateWithBiometrics();
      if (success) {
        // Save biometric enabled state
        await setBioMetric.call(true);
        emit(BiometricAuthSuccessState());
      } else {
        emit(
          BiometricAuthFailedState(
            AppStrings.biometricAuthenticationFailed,
            DateTime.now().toString(),
          ),
        );
      }
    });
  }
}
