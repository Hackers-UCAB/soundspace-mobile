import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/user/log_out_user_use_case.dart';
import 'package:sign_in_bloc/common/failure.dart';

part 'log_out_event.dart';
part 'log_out_state.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  final LogOutUserUseCase _logOutUserUseCase;
  LogOutBloc({required LogOutUserUseCase logOutUserUseCase})
      : _logOutUserUseCase = logOutUserUseCase,
        super(LogOutInitial()) {
    on<LogOutEvent>(_logOutHandler);
  }

  Future<void> _logOutHandler(
      LogOutEvent event, Emitter<LogOutState> emit) async {
    final result = await _logOutUserUseCase.execute(LogOutUserUseCaseInput());
    if (result.hasValue()) {
      // GetIt.instance.get<UserPermissionsBloc>().add(UserPermissionsChanged(
      //       isAuthenticated: false,
      //       isSubscribed: false,
      //     ));
      // emit(LogOutSuccess());
      emit(const LogOutFailed(failure: UnknownFailure(message: '')));
    } else {
      emit(LogOutFailed(failure: result.failure!));
    }
  }
}
