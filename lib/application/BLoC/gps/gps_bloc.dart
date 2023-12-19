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
            isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsInitializedEvent>(_gpsInitializedEvent);
    on<GpsStatusChangedEvent>(_gpsStatusChangedEvent);
    on<RequestedGpsAccess>(_requestedGpsAccessEvent);
    on<PermissionStatusChangedEvent>(_permissionStatusChangedEvent);
    //TODO: Poner el evento y el handler para verificar si esta en Venezuela
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
      //TODO: ejecutar el evento de si esta en Venezuela
    }
  }

  Future<void> _gpsStatusChangedEvent(
      GpsStatusChangedEvent event, Emitter<GpsState> emit) async {
    final gpsServiceSubscription = locationManager.locationStatusStream();
    await for (final isEnable in gpsServiceSubscription) {
      emit(state.copyWith(isGpsEnabled: isEnable));
      if (isEnable && state.isAllGranted) {
        //TODO: ejecutar el evento de si esta en Venezuela
      }
    }
  }

  //TODO: Hacer el handler para el evento de si esta en Venezuela

  Future<void> _permissionStatusChangedEvent(
      PermissionStatusChangedEvent event, Emitter<GpsState> emit) async {
    final isGranted = await locationManager.checkPermission();

    emit(state.copyWith(isGpsPermissionGranted: isGranted));
    if (isGranted && state.isGpsEnabled) {
      //TODO: ejecutar el evento de si esta en Venezuela
    }
  }

  Future<void> _requestedGpsAccessEvent(
      RequestedGpsAccess event, Emitter<GpsState> emit) async {
    await locationManager.requestPermission();
    add(PermissionStatusChangedEvent());
  }
}
