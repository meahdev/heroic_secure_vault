// Dart & Flutter core packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// State management
import 'package:flutter_bloc/flutter_bloc.dart';

// Routing
import 'package:go_router/go_router.dart';

// Screenshot prevention package
import 'package:no_screenshot/no_screenshot.dart';

// App-specific imports
import 'package:secure_vault/app/app_router.dart';
import 'package:secure_vault/core/theme/theme_cubit.dart';
import 'package:secure_vault/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:secure_vault/features/credential/presentation/bloc/credential_bloc.dart';
import 'package:secure_vault/features/password_generator/presentation/blocs/password_generator_bloc.dart';
import 'app/app_theme.dart';
import 'core/di/injection.dart';
import 'core/inactive/inactive_cubit.dart';
import 'core/storage/secure_storage_service.dart';
import 'core/storage/shared_prefs_service.dart';
import 'features/authentication/domain/use_cases/has_pin.dart';

void main() async {
  // Ensure Flutter bindings are initialized before calling platform channels
  WidgetsFlutterBinding.ensureInitialized();

  // Register dependency injections
  setupDependencies();

  // Initialize shared preferences
  await sl<SharedPrefsService>().init();

  // Clear secure storage on first install
  final secureStorageService = sl<SecureStorageService>();
  await secureStorageService.clearAllIfFirstInstall();

  // Disable screenshots across the app
  await NoScreenshot.instance.screenshotOff();

  // Lock app orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Launch the app with multiple BLoC providers
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<AuthBloc>()),
        BlocProvider.value(value: sl<ThemeCubit>()),
        BlocProvider.value(value: sl<CredentialBloc>()),
        BlocProvider.value(value: sl<PasswordGeneratorBloc>()),
        BlocProvider.value(value: sl<InactivityCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

// Root widget for the application
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Timer? _inactivityTimer;
  static const Duration lockDelay = Duration(minutes: 2);
  late final GoRouter _router;
  bool _appWasInBackground = false;
  final _noScreenshot = NoScreenshot.instance;
  int _latestTimerId = 0;

  // Shortcut to access the AuthBloc
  AuthBloc get _authBloc => context.read<AuthBloc>();

  @override
  void initState() {
    super.initState();
    // Register app lifecycle observer
    WidgetsBinding.instance.addObserver(this);

    // Create router with callback on route change
    _router = createAppRouter(
      context,
      _authBloc.stream,
      onRouteChange: (route) {
        //  Cancel timer first on any route change
        _inactivityTimer?.cancel();
        if (_shouldStartTimerOnRoute(route)) {
          _startInactivityTimer();
        }
      },
    );

    // Reset inactivity timer on user activity events
    context.read<InactivityCubit>().stream.listen((_) {
      _inactivityTimer?.cancel();
      _startInactivityTimer();
    });

    // Start listening for screenshots
    _noScreenshot.startScreenshotListening();
    _noScreenshot.screenshotStream.listen((snapshot) {
      debugPrint('Screenshot taken: ${snapshot.wasScreenshotTaken}');
      debugPrint('Screenshot path: ${snapshot.screenshotPath}');
    });
  }

  // Determine if auto-lock timer should be started based on route
  bool _shouldStartTimerOnRoute(String route) {
    const sensitiveRoutes = [
      '/credential',
      '/add-update-credential',
      '/passwordGenerator',
    ];
    return sensitiveRoutes.contains(route);
  }

  // Start/reset the inactivity timer with a unique ID to prevent race conditions
  void _startInactivityTimer() {
    _latestTimerId++;
    final currentTimerId = _latestTimerId;

    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(lockDelay, () => _handleAutoLock(currentTimerId));
  }

  // Perform auto-lock if the timer ID is still valid
  Future<void> _handleAutoLock(int timerId) async {
    if (timerId != _latestTimerId) return; // Ignore outdated timers

    try {
      final hasPin = await sl<HasPin>()();
      if (hasPin) {
        _authBloc.add(SetLockEvent(true));
      }
    } catch (e) {
      // Handle or log errors if needed
    }
  }

  // Handle lifecycle changes to manage lock state
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _startInactivityTimer();
      },
      onPanDown: (_) {
        _startInactivityTimer();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          _startInactivityTimer();
          return false;
        },
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
      ),
    );
  }

  @override
  void dispose() {
    // Remove lifecycle observer and cancel timers
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer?.cancel();
    super.dispose();
  }
}
