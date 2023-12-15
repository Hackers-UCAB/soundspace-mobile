import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/use_cases/user/get_user_local_data_use_case.dart';

import '../../../domain/user/valueObjects/user_role_value_object.dart';

part 'user_permissions_event.dart';
part 'user_permissions_state.dart';

class UserPermissionsBloc
    extends Bloc<UserPermissionsEvent, UserPermissionsState> {
  final GetUserLocalDataUseCase getUserLocalDataUseCase;

  UserPermissionsBloc({required this.getUserLocalDataUseCase})
      : super((const UserPermissionsState())) {
    on<UserPermissionsRequested>(_permissionsRequestedEventHandler);
    on<UserPermissionsChanged>(_permissionsChangedEventHandler);
  }

  void _permissionsRequestedEventHandler(
      UserPermissionsEvent event, Emitter<UserPermissionsState> emit) {
    final userResult = getUserLocalDataUseCase.execute();
    if (userResult.hasValue()) {
      final user = userResult.value;
      emit(state.copyWith(
          isAuthenticated: true,
          isSubscribed:
              (user?.role?.role == UserRoles.subscriber) ? true : false));
    }
  }

  void _permissionsChangedEventHandler(
      UserPermissionsChanged event, Emitter<UserPermissionsState> emit) {
    emit(state.copyWith(
        isAuthenticated: event.isAuthenticated,
        isSubscribed: event.isSubscribed));
  }
}
