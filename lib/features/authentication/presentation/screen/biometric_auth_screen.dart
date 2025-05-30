import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/core/constants/route_constants.dart';
import 'package:secure_vault/core/utils/snackbar_utils.dart';
import 'package:secure_vault/shared/widgets/custom_button/custom_button.dart';
import 'package:secure_vault/shared/widgets/custom_button/custom_text_button.dart';
import 'package:secure_vault/shared/widgets/custom_text/custom_text.dart';
import '../../../../core/constants/app_strings.dart';
import '../bloc/auth_bloc.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
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
            if (state is BiometricAuthFailedState) {
              context.goNamed(RouteConstants.enterPin);
              SnackBarUtils.showSnackBar(context, state.msg);
            } else if (state is BiometricAuthSuccessState) {
              context.goNamed(RouteConstants.credential);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  AppStrings.secureVaultLocked,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 27),
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: AppStrings.unlockWithBiometric,
                  fontSize: 16,
                  borderRadius: 8,
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthenticateBiometricsEvent());
                  },
                ),
                SizedBox(height: 130),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
