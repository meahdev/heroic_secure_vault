import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/core/utils/go_router_refresh_helper.dart';
import 'package:secure_vault/features/authentication/presentation/screen/biometric_auth_screen.dart';
import 'package:secure_vault/features/credential/presentation/screen/add_update_credential_screen.dart';
import '../core/constants/route_constants.dart';
import '../features/authentication/presentation/bloc/auth_bloc.dart';
import '../features/authentication/presentation/screen/enter_pin_screen.dart';
import '../features/authentication/presentation/screen/pin_confirm_screen.dart';
import '../features/authentication/presentation/screen/set_pin_screen.dart';
import '../features/credential/domain/entities/credential_entity.dart';
import '../features/credential/presentation/screen/credential_screen.dart';
import '../features/password_generator/presentation/screens/password_generator_screen.dart';
import '../splash_screen.dart';

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
    refreshListenable: GoRouterRefreshStreamHelper(authBlocStream),
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLocked = authState is LockUpdatedState && authState.locked;
      final isLockScreen = state.matchedLocation == '/enterPin';

      if (isLocked && !isLockScreen) return '/enterPin';
      return null;
    },
    initialLocation: '/',
    observers: [],
    // can't use NavigatorObserver directly, so skip
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
      GoRoute(
        name: RouteConstants.addUpdateCredential,
        path: '/add-update-credential',
        builder: (context, state) {
          final isEdit =
              state.extra != null && state.extra is Map
                  ? (state.extra as Map)['isEdit'] ?? false
                  : false;
          final credential =
              state.extra != null && state.extra is Map
                  ? (state.extra as Map)['credential'] as CredentialEntity?
                  : null;

          onRouteChange?.call('/add-update-credential');
          return AddUpdateCredentialScreen(
            isEdit: isEdit,
            credential: credential,
          );
        },
      ),
      GoRoute(
        name: RouteConstants.passwordGenerator,
        path: '/passwordGenerator',
        builder: (context, state) {
          onRouteChange?.call('/password-generator');
          return const PasswordGeneratorScreen();
        },
      ),
    ],
  );
}
