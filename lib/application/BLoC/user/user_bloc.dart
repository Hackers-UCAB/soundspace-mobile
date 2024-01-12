import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/use_cases/user/save_user_profile_data_use_case.dart';
import '../../../application/use_cases/user/get_user_profile_data_use_case.dart';
import '../../../common/result.dart';
import '../../../domain/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUserProfileDataUseCase fetchUserProfileDataUseCase;
  final SaveUserProfileDataUseCase saveUserProfileDataUseCase;

  UserBloc(
      {required this.fetchUserProfileDataUseCase,
      required this.saveUserProfileDataUseCase})
      : super(UserState(user: User(id: '', role: UserRoles.subscriber))) {
    on<FetchUserProfileDataEvent>(_fetchUserProfileData);
    on<ToggleProfileEditableEvent>(_toggleProfileEditable);
    on<NameEditedEvent>(_nameEdited);
    on<EmailEditedEvent>(_emailEdited);
    on<FechaEditedEvent>(_fechaEdited);
    on<GenderEditedEvent>(_genderEdited);
    on<SubmitChangesEvent>(_submitProfileChanges);
  }

  void _fetchUserProfileData(
      FetchUserProfileDataEvent event, Emitter<UserState> emit) async {
    Result<User> user = await fetchUserProfileDataUseCase.execute();
    if (user.hasValue()) {
      emit(state.copyWith(
        user: user.value,
        name: user.value?.name,
        email: user.value?.email,
        fecha: user.value?.birthdate.toString(),
        gender: user.value?.gender,
      ));
    }
  }

  void _toggleProfileEditable(
      ToggleProfileEditableEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(editable: !state.editable));
  }

  void _nameEdited(NameEditedEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _emailEdited(EmailEditedEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _fechaEdited(FechaEditedEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(fecha: event.fecha));
  }

  void _genderEdited(GenderEditedEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _submitProfileChanges(
      SubmitChangesEvent event, Emitter<UserState> emit) async {
    Result<User> result = await saveUserProfileDataUseCase.execute(event.user);
    if (result.hasValue()) {
      emit(state.copyWith(editable: !state.editable));
    }
  }
}
