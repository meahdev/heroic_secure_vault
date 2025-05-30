import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/credential_entity.dart';
import '../../domain/usecases/add_credential.dart';
import '../../domain/usecases/delete_credential.dart';
import '../../domain/usecases/get_all_credentials.dart';
import '../../domain/usecases/update_credential.dart';

part 'credential_event.dart';
part 'credential_state.dart';

/// Bloc responsible for managing credential-related states and events.
/// Handles loading, adding, updating, and deleting credentials.
class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  final GetAllCredentials getAllCredentials;
  final AddCredential addCredential;
  final UpdateCredential updateCredential;
  final DeleteCredential deleteCredential;

  /// Constructor initializes the bloc with required use cases.
  /// Sets the initial state to [CredentialInitial].
  CredentialBloc({
    required this.getAllCredentials,
    required this.addCredential,
    required this.updateCredential,
    required this.deleteCredential,
  }) : super(CredentialInitial()) {
    // Register event handlers for different CredentialEvents
    on<LoadCredentials>(_onLoad);
    on<AddCredentialEvent>(_onAdd);
    on<UpdateCredentialEvent>(_onUpdate);
    on<DeleteCredentialEvent>(_onDelete);
  }

  /// Handler for the [LoadCredentials] event.
  /// Emits [CredentialLoading] while fetching credentials,
  /// then emits [CredentialLoaded] on success or [CredentialError] on failure.
  Future<void> _onLoad(
      LoadCredentials event,
      Emitter<CredentialState> emit,
      ) async {
    emit(CredentialLoading());
    try {
      final credentials = await getAllCredentials();
      emit(CredentialLoaded(credentials));
    } catch (e, stackTrace) {
      emit(CredentialError('Failed to load credentials'));
    }
  }

  /// Handler for the [AddCredentialEvent].
  /// Calls use case to add the credential, then triggers reload.
  Future<void> _onAdd(
      AddCredentialEvent event,
      Emitter<CredentialState> emit,
      ) async {
    await addCredential(event.credential);
    add(LoadCredentials());
  }

  /// Handler for the [UpdateCredentialEvent].
  /// Calls use case to update the credential, then triggers reload.
  Future<void> _onUpdate(
      UpdateCredentialEvent event,
      Emitter<CredentialState> emit,
      ) async {
    await updateCredential(event.credential);
    add(LoadCredentials());
  }

  /// Handler for the [DeleteCredentialEvent].
  /// Calls use case to delete the credential by ID, then triggers reload.
  Future<void> _onDelete(
      DeleteCredentialEvent event,
      Emitter<CredentialState> emit,
      ) async {
    await deleteCredential(event.id);
    add(LoadCredentials());
  }
}
