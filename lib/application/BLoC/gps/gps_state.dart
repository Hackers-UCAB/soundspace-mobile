part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted; 
  final bool isInsideVenezuela;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

  const GpsState(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted, required this.isInsideVenezuela});

  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
    bool? isInsideVenezuela
  }) =>
      GpsState(
          isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
          isGpsPermissionGranted:isGpsPermissionGranted ?? this.isGpsPermissionGranted,
          isInsideVenezuela: isInsideVenezuela ?? this.isInsideVenezuela
      );

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted, isInsideVenezuela];

  @override
  String toString() =>
      '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';
}

class GpsInitial extends GpsState {
  const GpsInitial()
      : super(isGpsEnabled: false, isGpsPermissionGranted: false, isInsideVenezuela: false);
}
