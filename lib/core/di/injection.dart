import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:secure_vault/domain/use_cases/is_biometric_enabled.dart';
import 'package:secure_vault/domain/use_cases/set_biometric.dart';

import '../../data/datasources/auth_local_datasource.dart';
import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/authenticate_with_biometrics.dart';
import '../../domain/use_cases/has_pin.dart';
import '../../domain/use_cases/save_pin.dart';
import '../../domain/use_cases/verify_pin.dart';
import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../storage/secure_storage_service.dart';
import '../theme/theme_cubit.dart';

final sl = GetIt.instance;

/// Registers all dependencies using GetIt for service location.
///
/// This setup wires up:
/// - Services (e.g., local auth, secure storage)
/// - Repositories and data sources
/// - Use cases (application logic)
/// - BLoC state management
void setupDependencies() {
  // Services
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<LocalAuthentication>(() => LocalAuthentication());

  // Repository and Data Source
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      AuthLocalDataSourceImpl(sl()), // inject SecureStorageService
      sl(), // inject LocalAuthentication
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => SavePin(sl()));
  sl.registerLazySingleton(() => VerifyPin(sl()));
  sl.registerLazySingleton(() => HasPin(sl()));
  sl.registerLazySingleton(() => SetBioMetric(sl()));
  sl.registerLazySingleton(() => IsBiometricEnabled(sl()));
  sl.registerLazySingleton(() => AuthenticateWithBiometrics(sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      savePin: sl(),
      verifyPin: sl(),
      hasPin: sl(),
      setBioMetric: sl(),
      isBiometricEnabled: sl(),
      authenticateWithBiometrics: sl(),
    ),
  );
  // Theme Cubit
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
