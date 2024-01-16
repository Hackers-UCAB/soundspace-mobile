import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/user/cancel_user_subscription_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/user/save_user_profile_data_use_case.dart';
import '../../../application/use_cases/user/get_user_profile_data_use_case.dart';
import '../../../common/failure.dart';
import '../../../common/result.dart';
import '../../../domain/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUserProfileDataUseCase fetchUserProfileDataUseCase;
  final SaveUserProfileDataUseCase saveUserProfileDataUseCase;
  final CancelSubscriptionUseCase cancelSubscriptionUseCase;

  UserBloc(
      {required this.fetchUserProfileDataUseCase,
      required this.saveUserProfileDataUseCase,
      required this.cancelSubscriptionUseCase})
      : super(const UserProfileLoadingState(editData: {}, editable: false)) {
    on<FetchUserProfileDataEvent>(_fetchUserProfileData);
    on<ToggleProfileEditableEvent>(_toggleProfileEditable);
    on<NameEditedEvent>(_nameEdited);
    on<EmailEditedEvent>(_emailEdited);
    on<FechaEditedEvent>(_fechaEdited);
    on<GenreEditedEvent>(_genreEdited);
    on<SubmitChangesEvent>(_submitProfileChanges);
    on<CanceledSubscripcionEvent>(_cancelSubscription);
  }

  void _fetchUserProfileData(
      FetchUserProfileDataEvent event, Emitter<UserState> emit) async {
    emit(UserProfileLoadingState(
        editData: state.editData, editable: state.editable));
    Result<User> user = await fetchUserProfileDataUseCase.execute();
    if (user.hasValue()) {
      emit(UserProfileLoadedState(
          editable: state.editable,
          user: user.value!,
          editData: state.editData));
    } else {
      emit(UserProfileFaiLureState(failure: user.failure!));
    }
  }

  void _toggleProfileEditable(
      ToggleProfileEditableEvent event, Emitter<UserState> emit) {
    emit(UserProfileLoadedState(
        editable: !state.editable, user: event.user, editData: state.editData));
  }

  void _nameEdited(NameEditedEvent event, Emitter<UserState> emit) {
    User newUser = event.user;
    newUser.name = event.name;
    Map<String, String> newEditData = Map<String, String>.from(state.editData);
    newEditData['name'] = event.name;
    emit(UserProfileLoadedState(
        editable: state.editable, user: newUser, editData: newEditData));
  }

  void _emailEdited(EmailEditedEvent event, Emitter<UserState> emit) {
    User newUser = event.user;
    newUser.email = event.email;
    Map<String, String> newEditData = Map<String, String>.from(state.editData);
    newEditData['email'] = event.email;
    emit(UserProfileLoadedState(
        editable: state.editable, user: newUser, editData: newEditData));
  }

  void _fechaEdited(FechaEditedEvent event, Emitter<UserState> emit) {
    User newUser = event.user;
    newUser.birthdate = event.fecha;
    Map<String, String> newEditData = Map<String, String>.from(state.editData);
    newEditData['birthdate'] = DateFormat('MM/DD/yyyy').format(event.fecha);
    emit(UserProfileLoadedState(
        editable: state.editable, user: newUser, editData: newEditData));
  }

  void _genreEdited(GenreEditedEvent event, Emitter<UserState> emit) {
    User newUser = event.user;
    newUser.genre = event.genre;
    Map<String, String> newEditData = Map<String, String>.from(state.editData);
    newEditData['gender'] = event.genre; //TODO: Arreglar esto
    emit(UserProfileLoadedState(
        editable: state.editable, user: newUser, editData: newEditData));
  }

  void _submitProfileChanges(
      SubmitChangesEvent event, Emitter<UserState> emit) async {
    emit(UserProfileLoadingState(
        editData: state.editData, editable: state.editable));
    Result<String> result =
        await saveUserProfileDataUseCase.execute(state.editData);
    if (result.hasValue()) {
      emit(UserProfileLoadedState(
          editable: false, user: event.user, editData: const {}));
    }
  }

  Future<void> _cancelSubscription(
      CanceledSubscripcionEvent event, Emitter<UserState> emit) async {
    final result = await cancelSubscriptionUseCase
        .execute(CancelSubscriptionUseCaseInput());

    if (result.hasValue()) {
      GetIt.instance.get<UserPermissionsBloc>().add(
          UserPermissionsChanged(isAuthenticated: true, isSubscribed: false));
      emit(const UserProfileLoadingState(editData: {}, editable: false));
    }
  }
}
