import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/common/failure.dart';
import '../../use_cases/user/log_in_guest_use_case.dart';
import '../user_permissions/user_permissions_bloc.dart';
part 'log_in_guest_event.dart';
part 'log_in_guest_state.dart';

class LogInGuestBloc extends Bloc<LogInGuestEvent, LogInGuestState> {
  final LogInGuestUseCase _logInGuestUseCase;

  LogInGuestBloc({required LogInGuestUseCase logInGuestUseCase})
      : _logInGuestUseCase = logInGuestUseCase,
        super(LogInGuestInitial()) {
    on<LogInGuestSubmitted>(_onSubmited);
  }

  Future<void> _onSubmited(
      LogInGuestEvent event, Emitter<LogInGuestState> emit) async {
    final logInResult = await _logInGuestUseCase.execute();
    emit(LogInGuestPosting());

    if (logInResult.hasValue()) {
      GetIt.instance.get<UserPermissionsBloc>().add(
          UserPermissionsChanged(isAuthenticated: true, isSubscribed: false));
      emit(LogInGuestSuccess());
    } else {
      emit(LogInGuestFailure(failure: logInResult.failure!));
    }
  }
}
