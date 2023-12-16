part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsInitializedEvent extends GpsEvent {}

class GpsStatusChangedEvent extends GpsEvent {}

class RequestedGpsAccess extends GpsEvent {}
