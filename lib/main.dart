import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:secure_vault/app/app_router.dart';
import 'package:secure_vault/core/theme/theme_cubit.dart';
import 'package:secure_vault/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:secure_vault/features/credential/presentation/bloc/credential_bloc.dart';
import 'app/app_theme.dart';
import 'core/di/injection.dart';
import 'core/storage/secure_storage_service.dart';
import 'core/storage/shared_prefs_service.dart';
import 'features/authentication/domain/use_cases/has_pin.dart';

void main() async {
  // Ensures widgets & plugins are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Register all dependencies
  setupDependencies();
  // Initialize SharedPreferences inside the service
  await sl<SharedPrefsService>().init();
  final secureStorageService = sl<SecureStorageService>();
  await secureStorageService.clearAllIfFirstInstall();
  // 👇 Disable screenshots globally
  await NoScreenshot.instance.screenshotOff();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<AuthBloc>()),
        BlocProvider.value(value: sl<ThemeCubit>()),
        BlocProvider.value(value: sl<CredentialBloc>()),
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
  final _noScreenshot = NoScreenshot.instance;
  int _latestTimerId = 0;


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
    _noScreenshot.startScreenshotListening();
    _noScreenshot.screenshotStream.listen((snapshot) {
      debugPrint('Screenshot taken: ${snapshot.wasScreenshotTaken}');
      debugPrint('Screenshot path: ${snapshot.screenshotPath}');
    });
  }

  bool _shouldStartTimerOnRoute(String route) {
    const sensitiveRoutes = ['/credential'];
    return sensitiveRoutes.contains(route);
  }

  void _startInactivityTimer() {
    // _inactivityTimer?.cancel();
    // _inactivityTimer = Timer(lockDelay, _handleAutoLock);
    _latestTimerId++;
    final currentTimerId = _latestTimerId;

    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(lockDelay, () => _handleAutoLock(currentTimerId));
  }

  Future<void> _handleAutoLock(int timerId) async {
    if (timerId != _latestTimerId) return; // Cancel outdated timers

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
        _handleAutoLock(_latestTimerId);
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
