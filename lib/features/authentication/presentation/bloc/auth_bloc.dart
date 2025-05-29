import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_vault/core/constants/app_strings.dart';
import 'package:secure_vault/core/security/pin_rules.dart';
import 'package:secure_vault/domain/use_cases/is_biometric_enabled.dart';
import 'package:secure_vault/domain/use_cases/set_biometric.dart';

import '../../../../domain/use_cases/authenticate_with_biometrics.dart';
import '../../../../domain/use_cases/has_pin.dart';
import '../../../../domain/use_cases/save_pin.dart';
import '../../../../domain/use_cases/verify_pin.dart';

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
    on<PinEntered>((event, emit) async {
      if (!PinRules.isValid(event.pin)) {
        emit(SetPinFailedState(AppStrings.pinBlock, DateTime.now().toString()));
        return;
      }
      emit(SetPinConfirmState(event.pin, DateTime.now().toString()));
    });

    on<PinConfirmed>((event, emit) async {
      if (event.firstPin == event.confirmPin) {
        emit(AuthLoading());
        await savePin.call(event.confirmPin);
        emit(PinSavedState());
      } else {
        emit(
          ConfirmPinFailedState(
            AppStrings.pinDoesNotMatch,
            DateTime.now().toString(),
          ),
        );
      }
    });

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

    on<CheckHasPinEvent>((event, emit) async {
      emit(AuthLoading());
      final exists = await hasPin();
      // We could add states to reflect this if needed
      emit(exists ? PinSavedState() : PinNotSavedState());
    });

    on<CheckHasBioMetricEvent>((event, emit) async {
      emit(AuthLoading());
      final exists = await isBiometricEnabled();
      if (exists) {
        emit(exists ? BioMetricSavedState() : BioMetricNotSavedState());
      } else {
        // Chain to check PIN if biometric is not enabled
        add(CheckHasPinEvent());
      }
    });

    on<SetLockEvent>((event, emit) async {
      emit(LockUpdatedState(event.locked));
    });

    on<AuthenticateBiometricsEvent>((event, emit) async {
      emit(AuthLoading());
      final success = await authenticateWithBiometrics();
      if (success) {
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
