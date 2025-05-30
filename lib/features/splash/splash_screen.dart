import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/shared/widgets/custom_loader/custom_loader.dart';

import '../../core/constants/route_constants.dart';
import '../authentication/presentation/bloc/auth_bloc.dart';

/// Splash screen responsible for initial routing based on PIN availability.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Trigger check for saved PIN after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckHasBioMetricEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen:
          (previous, current) =>
              current is PinSavedState ||
              current is PinNotSavedState ||
              current is BioMetricSavedState,
      listener: (context, state) {
        if (state is BioMetricSavedState) {
          _navigateOnce(RouteConstants.bioMetricAuth);
        } else if (state is PinSavedState) {
          _navigateOnce(RouteConstants.enterPin);
        } else {
          _navigateOnce(RouteConstants.setPin);
        }
      },
      child: const Scaffold(body: CustomLoader()),
    );
  }

  /// Prevents multiple navigations by guarding with [_navigated] flag.
  void _navigateOnce(String routeName) {
    if (_navigated) return;
    _navigated = true;
    context.goNamed(routeName);
  }
}
