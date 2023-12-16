import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/services/location/location_manager.dart';
import 'package:sign_in_bloc/application/services/location/location_permission_manager.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  final LocationManager locationManager;
  final LocationPermission locationPermission;

  GpsBloc({required this.locationManager, required this.locationPermission})
      : super(const GpsState(
            isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsInitializedEvent>(_gpsInitializedEvent);
    on<GpsStatusChangedEvent>(_gpsStatusChangedEvent);
    on<RequestedGpsAccess>(_requestedGpsAccessEvent);
  }

  Future<void> _gpsInitializedEvent(
      GpsInitializedEvent event, Emitter<GpsState> emit) async {
    final isEnable = await locationManager.isLocationServiceEnabled();
    final isGranted = await locationPermission.isPermissionGranted();

    emit(state.copyWith(
        isGpsEnabled: isEnable, isGpsPermissionGranted: isGranted));
  }

  Future<void> _gpsStatusChangedEvent(
      GpsStatusChangedEvent event, Emitter<GpsState> emit) async {
    final gpsServiceSubscription = locationManager.locationStatusStream();
    await for (final isEnable in gpsServiceSubscription) {
      emit(state.copyWith(isGpsEnabled: isEnable));
    }
  }

  Future<void> _requestedGpsAccessEvent(
      RequestedGpsAccess event, Emitter<GpsState> emit) async {
    final status = await locationPermission.requestPermission();

    status
        ? emit(state.copyWith(isGpsPermissionGranted: true))
        : emit(state.copyWith(isGpsPermissionGranted: false));

    final isGranted = await locationPermission.requestPermission();
    emit(state.copyWith(isGpsPermissionGranted: isGranted));
  }
}
