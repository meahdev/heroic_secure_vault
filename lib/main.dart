import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_vault/app/app_router.dart';
import 'package:secure_vault/core/theme/theme_cubit.dart';
import 'package:secure_vault/features/authentication/presentation/bloc/auth_bloc.dart';
import 'app/app_theme.dart';
import 'core/di/injection.dart';
import 'core/storage/secure_storage_service.dart';
import 'domain/use_cases/has_pin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  final secureStorageService = sl<SecureStorageService>();
  await secureStorageService.clearAllIfFirstInstall();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<AuthBloc>()),
        BlocProvider.value(value: sl<ThemeCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Timer? _inactivityTimer;
  static const Duration lockDelay = Duration(seconds: 20);
  late final GoRouter _router;
  bool _appWasInBackground = false;

  AuthBloc get _authBloc => context.read<AuthBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _router = createAppRouter(
      context,
      _authBloc.stream,
      onRouteChange: (route) {
        if (_shouldStartTimerOnRoute(route)) {
          _startInactivityTimer();
        }
      },
    );
  }

  bool _shouldStartTimerOnRoute(String route) {
    const sensitiveRoutes = ['/credential'];
    return sensitiveRoutes.contains(route);
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(lockDelay, _handleAutoLock);
  }

  Future<void> _handleAutoLock() async {
    try {
      final hasPin = await sl<HasPin>()();
      if (hasPin) {
        _authBloc.add(SetLockEvent(true));
      }
    } catch (e) {
      // Handle or log if necessary
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _appWasInBackground = true;
        _handleAutoLock();
        break;
      case AppLifecycleState.resumed:
        if (_appWasInBackground) {
          _startInactivityTimer();
        }
        _appWasInBackground = false;
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _startInactivityTimer(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Secure Vault',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            routerConfig: _router,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer?.cancel();
    super.dispose();
  }
}
