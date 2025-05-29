import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/core/utils/snackbar_utils.dart';
import 'package:secure_vault/shared/dialogs/alert_view.dart';
import 'package:secure_vault/shared/widgets/custom_text/custom_text.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../shared/widgets/pin_input_field/pin_input.dart';
import '../bloc/auth_bloc.dart';

class PinConfirmScreen extends StatefulWidget {
  const PinConfirmScreen({super.key});

  @override
  State<PinConfirmScreen> createState() => _PinConfirmScreenState();
}

class _PinConfirmScreenState extends State<PinConfirmScreen> {
  final TextEditingController _confirmPinController = TextEditingController();
  final FocusNode _confirmPinFocusNode = FocusNode();
  String? _firstPin;

  @override
  void initState() {
    super.initState();
    _confirmPinFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _confirmPinController.dispose();
    _confirmPinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listenWhen:
              (previous, current) =>
                  current is ConfirmPinFailedState ||
                  current is PinSavedState ||
                  current is BiometricAuthSuccessState ||
                  current is BiometricAuthFailedState,
          listener: (_, state) {
            if (state is ConfirmPinFailedState) {
              _showAlert(context, state.msg);
            } else if (state is PinSavedState) {
              context.read<AuthBloc>().add(AuthenticateBiometricsEvent());
            } else if (state is BiometricAuthSuccessState) {
              context.goNamed(RouteConstants.credential);
              SnackBarUtils.showSnackBar(
                context,
                AppStrings.biometricAuthenticationEnabled,
              );
            } else if (state is BiometricAuthFailedState) {
              context.goNamed(RouteConstants.credential);
              SnackBarUtils.showSnackBar(
                context,
                AppStrings.biometricAuthenticationFallback,
              );
            }
          },
          builder: (context, state) {
            // Get the first PIN from the BLoC state if available
            if (state is SetPinConfirmState) {
              _firstPin = state.firstPin;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  CustomText(
                    AppStrings.confirmPin,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  PinInput(
                    pinController: _confirmPinController,
                    pinFocusNode: _confirmPinFocusNode,
                    onCompleted: (pin) {
                      if (_firstPin != null) {
                        context.read<AuthBloc>().add(
                          PinConfirmed(firstPin: _firstPin!, confirmPin: pin),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertView(
          title: AppStrings.securityVault,
          onPositiveTap: () {
            _confirmPinController.clear();
            Navigator.pop(context);
          },
          onCancelTap: () {
            Navigator.pop(context);
          },
          message: AppStrings.pinDoesNotMatch,
          positiveLabel: AppStrings.ok,
        );
      },
    );
  }
}
