
part of 'credential_bloc.dart';

abstract class CredentialEvent extends Equatable {
  const CredentialEvent();

  @override
  List<Object?> get props => [];
}

class LoadCredentials extends CredentialEvent {}

class AddCredentialEvent extends CredentialEvent {
  final CredentialEntity credential;

  const AddCredentialEvent(this.credential);

  @override
  List<Object?> get props => [credential];
}

class UpdateCredentialEvent extends CredentialEvent {
  final CredentialEntity credential;

  const UpdateCredentialEvent(this.credential);

  @override
  List<Object?> get props => [credential];
}

class DeleteCredentialEvent extends CredentialEvent {
  final String id;

  const DeleteCredentialEvent(this.id);

  @override
  List<Object?> get props => [id];
}