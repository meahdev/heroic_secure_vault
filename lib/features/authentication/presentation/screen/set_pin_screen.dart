import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/core/constants/app_strings.dart';
import 'package:secure_vault/shared/widgets/custom_text/custom_text.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../shared/dialogs/alert_view.dart';
import '../../../../shared/widgets/pin_input_field/pin_input.dart';
import '../bloc/auth_bloc.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _pinFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen:
              (previous, current) =>
                  current is SetPinConfirmState || current is SetPinFailedState,
          listener: (context, state) {
            if(state is SetPinFailedState){
              _showAlert(context, state.msg);
            }
            else if (state is SetPinConfirmState) {
              context.pushNamed(
                RouteConstants.pinConfirm,
              ).then((value) {
                _pinFocusNode.requestFocus();
              });
              // clear value after navigation
              _pinController.clear();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                CustomText(
                  AppStrings.create4DigitPin,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                CustomText(
                  AppStrings.pinInstruction,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 20),
                PinInput(
                  pinController: _pinController,
                  pinFocusNode: _pinFocusNode,
                  onCompleted: (pin) {
                    context.read<AuthBloc>().add(PinEntered(pin));
                  },
                ),
              ],
            ),
          ),
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
          isCancelButton: false,
          title: AppStrings.securityVault,
          onPositiveTap: () {
            _pinController.clear();
            Navigator.pop(context);
          },
          message:message,
          positiveLabel: AppStrings.ok,
        );
      },
    );
  }
}
