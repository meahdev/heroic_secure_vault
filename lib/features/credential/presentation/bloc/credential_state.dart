part of 'credential_bloc.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object?> get props => [];
}

class CredentialInitial extends CredentialState {}

class CredentialLoading extends CredentialState {}

class CredentialLoaded extends CredentialState {
  final List<CredentialEntity> credentials;

  const CredentialLoaded(this.credentials);

  @override
  List<Object?> get props => [credentials];
}

class CredentialError extends CredentialState {
  final String message;

  const CredentialError(this.message);

  @override
  List<Object?> get props => [message];
}