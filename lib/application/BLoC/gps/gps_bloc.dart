import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/application/services/location/location_manager.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  final LocationManager locationManager;
  final UserPermissionsBloc userPermissionsBloc;

  GpsBloc({
    required this.userPermissionsBloc,
    required this.locationManager,
  }) : super(const GpsState(
            isGpsEnabled: false,
            isGpsPermissionGranted: false,
            isInsideVenezuela: true)) {
    on<GpsInitializedEvent>(_gpsInitializedEvent);
    on<GpsStatusChangedEvent>(_gpsStatusChangedEvent);
    on<RequestedGpsAccess>(_requestedGpsAccessEvent);
    on<PermissionStatusChangedEvent>(_permissionStatusChangedEvent);
    on<CheckedIfInsideVenezuelaEvent>(_checkIfInsideVenezuelaEvent);
    userPermissionsBloc.stream.listen((state) {
      if (state.isSubscribed) {
        add(GpsInitializedEvent());
      }
    });
  }

  Future<void> _gpsInitializedEvent(
      GpsInitializedEvent event, Emitter<GpsState> emit) async {
    final isEnable = await locationManager.isLocationServiceEnabled();
    final isGranted = await locationManager.checkPermission();

    add(GpsStatusChangedEvent());

    emit(state.copyWith(
        isGpsEnabled: isEnable, isGpsPermissionGranted: isGranted));

    if (isEnable && isGranted) {
      add(CheckedIfInsideVenezuelaEvent());
    }
  }

  Future<void> _gpsStatusChangedEvent(
      GpsStatusChangedEvent event, Emitter<GpsState> emit) async {
    final gpsServiceSubscription = locationManager.locationStatusStream();

    await for (final isEnable in gpsServiceSubscription) {
      emit(state.copyWith(isGpsEnabled: isEnable));
      if (isEnable && state.isAllGranted) {
        add(CheckedIfInsideVenezuelaEvent());
      }
    }
  }

  Future<void> _permissionStatusChangedEvent(
      PermissionStatusChangedEvent event, Emitter<GpsState> emit) async {
    final isGranted = await locationManager.checkPermission();

    emit(state.copyWith(isGpsPermissionGranted: isGranted));
    if (isGranted && state.isGpsEnabled) {
      add(CheckedIfInsideVenezuelaEvent());
    }
  }

  Future<void> _requestedGpsAccessEvent(
      RequestedGpsAccess event, Emitter<GpsState> emit) async {
    await locationManager.requestPermission();
    add(PermissionStatusChangedEvent());
  }

  Future<void> _checkIfInsideVenezuelaEvent(
      CheckedIfInsideVenezuelaEvent event, Emitter<GpsState> emit) async {
    final isInsideVenezuela = await locationManager.isLocationVenezuela();
    emit(state.copyWith(isInsideVenezuela: isInsideVenezuela));

    // await for (final isInside in locationManager.isLocationVenezuela()) {
    //   emit(state.copyWith(isInsideVenezuela: isInside));
    // }
  }
}
