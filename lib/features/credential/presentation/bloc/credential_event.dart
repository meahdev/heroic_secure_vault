part of 'credential_bloc.dart';

/// Base class for all Credential-related events.
/// Extends Equatable for value comparison.
abstract class CredentialEvent extends Equatable {
  const CredentialEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all credentials.
/// Triggers fetching of credentials from repository or data source.
class LoadCredentials extends CredentialEvent {}

/// Event to add a new credential.
/// Carries the [CredentialEntity] to be added.
class AddCredentialEvent extends CredentialEvent {
  final CredentialEntity credential;

  const AddCredentialEvent(this.credential);

  @override
  List<Object?> get props => [credential];
}

/// Event to update an existing credential.
/// Carries the updated [CredentialEntity].
class UpdateCredentialEvent extends CredentialEvent {
  final CredentialEntity credential;

  const UpdateCredentialEvent(this.credential);

  @override
  List<Object?> get props => [credential];
}

/// Event to delete a credential by ID.
/// Carries the ID of the credential to be deleted.
class DeleteCredentialEvent extends CredentialEvent {
  final String id;

  const DeleteCredentialEvent(this.id);

  @override
  List<Object?> get props => [id];
}
