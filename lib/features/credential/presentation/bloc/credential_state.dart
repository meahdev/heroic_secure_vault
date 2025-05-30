part of 'credential_bloc.dart';

/// Base class for all Credential-related states.
/// Extends Equatable for value comparison.
abstract class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action is performed.
class CredentialInitial extends CredentialState {}

/// State emitted when credentials are being loaded.
class CredentialLoading extends CredentialState {}

/// State emitted when credentials have been successfully loaded.
/// Contains a list of [CredentialEntity] objects.
class CredentialLoaded extends CredentialState {
  final List<CredentialEntity> credentials;

  const CredentialLoaded(this.credentials);

  @override
  List<Object?> get props => [credentials];
}

/// State emitted when there is an error loading credentials.
/// Contains an error message.
class CredentialError extends CredentialState {
  final String message;

  const CredentialError(this.message);

  @override
  List<Object?> get props => [message];
}
