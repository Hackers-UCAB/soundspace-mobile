import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/use_cases/user/get_user_local_data_use_case.dart';
import 'package:sign_in_bloc/common/failure.dart';
import 'package:sign_in_bloc/domain/services/location_checker.dart';

import '../../../domain/user/user.dart';
import '../../services/internet_connection/connection_manager.dart';

part 'user_permissions_event.dart';
part 'user_permissions_state.dart';

class UserPermissionsBloc
    extends Bloc<UserPermissionsEvent, UserPermissionsState> {
  final GetUserLocalDataUseCase getUserLocalDataUseCase;
  final ILocationChecker locationChecker;
  final IConnectionManager connectionManager;

  UserPermissionsBloc(
      {required this.getUserLocalDataUseCase,
      required this.locationChecker,
      required this.connectionManager})
      : super((const UserPermissionsState())) {
    on<UserPermissionsRequested>(_permissionsRequestedEventHandler);
    on<UserPermissionsChanged>(_permissionsChangedEventHandler);
  }

  Future<void> _permissionsRequestedEventHandler(
      UserPermissionsEvent event, Emitter<UserPermissionsState> emit) async {
    final userResult =
        await getUserLocalDataUseCase.execute(GetUserLocalDataUseCaseInput());
    if (userResult.hasValue()) {
      final user = userResult.value!;

      emit(state.copyWith(
          isAuthenticated: true,
          isSubscribed: (user.role == UserRoles.subscriber) ? true : false));

      try {
        await user.checkLocation(locationChecker, connectionManager);
        emit(state.copyWith(
            isSubscribed: (user.role == UserRoles.subscriber) ? true : false,
            validLocation: user.validLocation()));
      } catch (error) {
        emit(UserPermissionsFailed(
            failure: UnnableToCheckLocationFailure(message: error.toString())));
      }
    }
  }

  void _permissionsChangedEventHandler(
      UserPermissionsChanged event, Emitter<UserPermissionsState> emit) {
    emit(state.copyWith(
        isAuthenticated: event.isAuthenticated,
        isSubscribed: event.isSubscribed));
  }
}
