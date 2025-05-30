import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/credential_entity.dart';
import '../../domain/usecases/add_credential.dart';
import '../../domain/usecases/delete_credential.dart';
import '../../domain/usecases/get_all_credentials.dart';
import '../../domain/usecases/update_credential.dart';

part 'credential_event.dart';

part 'credential_state.dart';

class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  final GetAllCredentials getAllCredentials;
  final AddCredential addCredential;
  final UpdateCredential updateCredential;
  final DeleteCredential deleteCredential;

  CredentialBloc({
    required this.getAllCredentials,
    required this.addCredential,
    required this.updateCredential,
    required this.deleteCredential,
  }) : super(CredentialInitial()) {
    on<LoadCredentials>(_onLoad);
    on<AddCredentialEvent>(_onAdd);
    on<UpdateCredentialEvent>(_onUpdate);
    on<DeleteCredentialEvent>(_onDelete);
  }

  Future<void> _onLoad(
    LoadCredentials event,
    Emitter<CredentialState> emit,
  ) async {
    emit(CredentialLoading());
    try {
      final credentials = await getAllCredentials();
      emit(CredentialLoaded(credentials));
    } catch (e,stackTrace) {
      emit(CredentialError('Failed to load credentials'));
    }
  }

  Future<void> _onAdd(
    AddCredentialEvent event,
    Emitter<CredentialState> emit,
  ) async {
    await addCredential(event.credential);
    add(LoadCredentials());
  }

  Future<void> _onUpdate(
    UpdateCredentialEvent event,
    Emitter<CredentialState> emit,
  ) async {
    await updateCredential(event.credential);
    add(LoadCredentials());
  }

  Future<void> _onDelete(
    DeleteCredentialEvent event,
    Emitter<CredentialState> emit,
  ) async {
    await deleteCredential(event.id);
    add(LoadCredentials());
  }
}
