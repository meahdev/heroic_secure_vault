import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/features/authentication/presentation/screen/biometric_auth_screen.dart';
import '../core/constants/route_constants.dart';
import '../features/authentication/presentation/bloc/auth_bloc.dart';
import '../features/authentication/presentation/screen/enter_pin_screen.dart';
import '../features/authentication/presentation/screen/pin_confirm_screen.dart';
import '../features/authentication/presentation/screen/set_pin_screen.dart';
import '../features/credential/presentation/screen/credential_screen.dart';
import '../features/splash/splash_screen.dart';

/// Creates and configures the main app app_router using GoRouter.
///
/// This app_router manages navigation between splash, authentication,
/// and credential screens.
GoRouter createAppRouter(
    BuildContext context,
    Stream authBlocStream, {
      void Function(String)? onRouteChange,
    }) {
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBlocStream),
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLocked = authState is LockUpdatedState && authState.locked;
      final isLockScreen = state.matchedLocation == '/enterPin';

      if (isLocked && !isLockScreen) return '/enterPin';
      return null;
    },
    initialLocation: '/',
    observers: [], // can't use NavigatorObserver directly, so skip
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          onRouteChange?.call('/');
          return const SplashScreen();
        },
      ),
      GoRoute(
        name: RouteConstants.bioMetricAuth,
        path: '/biometricAuth',
        builder: (context, state) {
          onRouteChange?.call('/biometricAuth');
          return const BiometricAuthScreen();
        },
      ),
      GoRoute(
        name: RouteConstants.enterPin,
        path: '/enterPin',
        builder: (context, state) {
          onRouteChange?.call('/enterPin');
          return const EnterPinScreen();
        },
      ),
      GoRoute(
        name: RouteConstants.setPin,
        path: '/setPin',
        builder: (context, state) {
          onRouteChange?.call('/setPin');
          return const SetPinScreen();
        },
      ),
      GoRoute(
        name: RouteConstants.pinConfirm,
        path: '/pinConfirm',
        builder: (context, state) {
          onRouteChange?.call('/pinConfirm');
          return const PinConfirmScreen();
        },
      ),
      GoRoute(
        name: RouteConstants.credential,
        path: '/credential',
        builder: (context, state) {
          onRouteChange?.call('/credential');
          return const CredentialScreen();
        },
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
