import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import '../../features/authentication/data/datasources/auth_local_datasource.dart';
import '../../features/authentication/data/repositories_impl/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/domain/use_cases/authenticate_with_biometrics.dart';
import '../../features/authentication/domain/use_cases/has_pin.dart';
import '../../features/authentication/domain/use_cases/is_biometric_enabled.dart';
import '../../features/authentication/domain/use_cases/save_pin.dart';
import '../../features/authentication/domain/use_cases/set_biometric.dart';
import '../../features/authentication/domain/use_cases/verify_pin.dart';
import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../features/credential/data/datasources/credential_local_datasource.dart';
import '../../features/credential/data/repositories_impl/credential_repository_impl.dart';
import '../../features/credential/domain/repositories/credential_repository.dart';
import '../../features/credential/domain/usecases/add_credential.dart';
import '../../features/credential/domain/usecases/delete_credential.dart';
import '../../features/credential/domain/usecases/get_all_credentials.dart';
import '../../features/credential/domain/usecases/update_credential.dart';
import '../../features/credential/presentation/bloc/credential_bloc.dart';
import '../../features/password_generator/data/repositories_impl/password_repository_impl.dart';
import '../../features/password_generator/domain/repositories/password_repository.dart';
import '../../features/password_generator/domain/usecases/evaluate_password_strength.dart';
import '../../features/password_generator/domain/usecases/generate_password.dart';
import '../../features/password_generator/presentation/blocs/password_generator_bloc.dart';
import '../inactive/inactive_cubit.dart';
import '../storage/secure_storage_service.dart';
import '../storage/shared_prefs_service.dart';
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
  // Initialize SharedPrefsService
  sl.registerLazySingleton<SharedPrefsService>(() => SharedPrefsService());

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
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl()));

  // -------------------------------
  // Credential Feature Dependencies
  // -------------------------------

  // Data Source
  sl.registerLazySingleton<CredentialLocalDataSource>(
    () => CredentialLocalDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<CredentialRepository>(
    () => CredentialRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => AddCredential(sl()));
  sl.registerLazySingleton(() => DeleteCredential(sl()));
  sl.registerLazySingleton(() => UpdateCredential(sl()));
  sl.registerLazySingleton(() => GetAllCredentials(sl()));

  // Bloc  for Credential Feature
  sl.registerFactory(
    () => CredentialBloc(
      addCredential: sl(),
      deleteCredential: sl(),
      updateCredential: sl(),
      getAllCredentials: sl(),
    ),
  );

  // ----------------------------------------
  // Password Generator Feature Dependencies
  // ----------------------------------------

  //Repository

  sl.registerLazySingleton<PasswordGeneratorRepository>(
    () => PasswordGeneratorRepositoryImpl(),
  );
  // Use Cases
  sl.registerLazySingleton(() => GeneratePassword(sl()));
  sl.registerLazySingleton(() => EvaluatePasswordStrength(sl()));

  // Bloc for Password Generator
  sl.registerFactory(
    () => PasswordGeneratorBloc(generatePassword: sl(), evaluateStrength: sl()),
  );

  // InActivity  Cubit
  sl.registerLazySingleton<InactivityCubit>(() => InactivityCubit());
}
