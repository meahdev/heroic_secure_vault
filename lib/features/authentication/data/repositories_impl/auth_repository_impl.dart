import 'package:local_auth/local_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

/// Implementation of [AuthRepository] that handles authentication
/// and secure PIN storage using [AuthLocalDataSource] and [LocalAuthentication].
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final LocalAuthentication localAuth;

  AuthRepositoryImpl(this.localDataSource, this.localAuth);

  @override
  Future<void> savePin(String pin) => localDataSource.savePin(pin);

  @override
  Future<bool> verifyPin(String pin) async {
    final storedPin = await localDataSource.getPin();
    return storedPin == pin;
  }

  @override
  Future<bool> hasPin() => localDataSource.hasPin();

  @override
  Future<bool> authenticateWithBiometrics() async {
    final canCheckBiometrics = await localAuth.canCheckBiometrics;
    final isDeviceSupported = await localAuth.isDeviceSupported();
    final isSupported = canCheckBiometrics && isDeviceSupported;

    if (!isSupported) return false;
    try {
      return await localAuth.authenticate(
        localizedReason: 'Authenticate to unlock Secure Vault',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isBioMetricEnabled() => localDataSource.isBioMetricEnabled();

  @override
  Future<void> setBioMetric(bool isEnabled) =>
      localDataSource.setBioMetric(isEnabled);
}
