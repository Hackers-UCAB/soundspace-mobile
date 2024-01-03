import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../application/use_cases/user/get_user_profile_data_use_case.dart';
import '../../../common/result.dart';
import '../../../domain/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUserProfileDataUseCase fetchUserProfileDataUseCase;

  UserBloc({required this.fetchUserProfileDataUseCase})
      : super(UserState(fecha: DateTime.now())) {
    on<FetchUserProfileDataEvent>(_fetchUserProfileData);
    on<ToggleProfileEditableEvent>(_toggleProfileEditable);
    on<EditingFechaEvent>(_editingFecha);
  }

  void _fetchUserProfileData(
      FetchUserProfileDataEvent event, Emitter<UserState> emit) async {
    Result<User> user = await fetchUserProfileDataUseCase.execute();
    if (user.hasValue()) {
      emit(state.copyWith(user: user.value));
    }
  }

  void _toggleProfileEditable(
      ToggleProfileEditableEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(editable: !state.editable));
  }

  void _editingFecha(EditingFechaEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(fecha: event.fecha));
  }
}
