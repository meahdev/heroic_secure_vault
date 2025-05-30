import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/core/constants/route_constants.dart';
import 'package:secure_vault/shared/dialogs/alert_view.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/pin_input_field/pin_input.dart';
import '../bloc/auth_bloc.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key});

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
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
          listener: (context, state) {
            if (state is PinVerificationFailedState) {
              _showAlert(context);
            }else if(state is PinVerifiedState){
              context.goNamed(RouteConstants.credential);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Text(
                  AppStrings.enterPin,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                PinInput(
                  pinController: _pinController,
                  pinFocusNode: _pinFocusNode,
                  onCompleted: (pin) {
                    context.read<AuthBloc>().add(VerifyPinEvent(pin));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertView(
          isCancelButton: false,
          title: AppStrings.securityVault,
          onPositiveTap: () {
            Navigator.pop(context);
            _pinController.clear();
            _pinFocusNode.requestFocus();

          },
          message: AppStrings.pinDoesNotMatch,
          positiveLabel: AppStrings.ok,
        );
      },
    );
  }
}
